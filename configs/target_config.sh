#!/usr/bin/env bash
# shellcheck disable=SC2034

# These function here are more or less copy pasted for each architecture,
# which is usually a bad programming habit, however, it makes sense
# have a config function for each architecture, as it is possible
# to inject different architecure dependent configuration settings for the build here.

function setup_default_config()
{
    # Configuration variables

    # binutils and gdb share the same git repo, which is fine,
    # however, when downloading the binutils release it comes without
    # gdb and vice versa. And when cloning the via git the gdb is included
    # and will also be built even if we do not want it. 
    # Which is kinda crap. So we explicitely add --disable-gdb and 
    # for gdb down below we add --disable-binutils
    BINUTILS_BASE_CONFIG=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--disable-nls"
        "--disable-werror"
        "--disable-gdb"
        "--with-sysroot"
    )

    # If you want to enable c++ please specify:
    #local enable_languages="c,c++"
    local enable_languages="c"
    local fake_cpp=""

    if [[ ${enable_languages} = "c" ]]; then
        fake_cpp="fake"
    fi

    # According to the gcc docs bootstrap is only enabled for native builds by default.
    # For cross compile builds it is disabled by default.
    # We explicitely add --disable-bootstrap here to have the same build-behavior for all
    # targets and because of a new issue with isl-0.22:
    # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92484
    GCC_BASE_CONFIG=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--disable-nls"
        "--disable-bootstrap"
        "--enable-languages=${enable_languages}"
    )

    # Notes:
    # Add CC and a fake CXX to circumvent an issue in glibc in case of a c only build:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=24183
    #
    # CFLAGS: It seems there is an issue when building glibc with GCC-11, so we add
    # the CLFLAGS "-Wno-error=stringop-overread" to disable a warning introduced with GCC-11 during build,
    # which is otherwise treated as an error (-Werror). 
    # For further info, see:
    # https://github.com/advancetoolchain/advance-toolchain/issues/1876
    # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98512
    # http://sourceware-org.1504.n7.nabble.com/PATCH-string-Fix-GCC-11-Werror-stringop-overread-error-td647550.html
    GLIBC_BASE_CONFIG=(
        "CFLAGS='-g -O2 \
            -Wno-error=stringop-overread'"
        "CC=${TARGET}-gcc"
        "CXX=${TARGET}${fake_cpp}-g++"
        "--host=${TARGET}"
        "--prefix=${INSTALL}/${TARGET}"
        "--with-headers=${INSTALL}/${TARGET}/include"
    )

    NEWLIB_BASE_CONFIGURATION=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
    )

    NEWLIB_NANO_INSTALL_DIR="${INSTALL}/${TARGET}/newlib-nano"
    NEWLIB_NANO_BASE_CONFIGURATION=(
        "--target=${TARGET}"
        "--prefix=${NEWLIB_NANO_INSTALL_DIR}"
    )

    # Although GMP is already built with GCC (in-tree) it is now also a 'host' library 
    # dependency for GDB since version 11.
    # So we now need to explicitely build and install it for the host.
    local GMP_INSTALL_DIR="${BUILD_DIR}/build-gmp/__installed"
    GMP_BASE_CONFIG=(
        "--prefix=${GMP_INSTALL_DIR}"
    )

    GDB_BASE_CONFIG=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--with-libgmp-prefix=${GMP_INSTALL_DIR}"
        "--disable-binutils"
        "--disable-ld"
        "--disable-gas"
        "--with-expat"
    )

    MINGW_HEADER_BASE_CONFIG=(
        "--prefix=${INSTALL}/${TARGET}"
        "--host=${TARGET}"
    )

    MINGW_CRT_BASE_CONFIG=(
        "--prefix=${INSTALL}/${TARGET}"
        "--with-sysroot=${INSTALL}/${TARGET}"
        "--host=${TARGET}"
    )

    # Note:
    # Since GCC-11 we need to add CFLAGS='-fno-expensive-optimizations' to this build, for details see:
    # https://bugs.gentoo.org/787662
    MINGW_WINPTHREADS_BASE_CONFIG=(
        "CFLAGS='-fno-expensive-optimizations'"
        "--prefix=${INSTALL}/${TARGET}"
        "--host=${TARGET}"
        "--disable-multilib"
    )
}

function setup_baremetal_default_downloadfuncs() {
    DOWNLOAD_FUNCS=("fetch_source ${NEWLIB_URL} newlib-${NEWLIB}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${GCC_URL} gcc-${GCC}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
                    "fetch_source ${GDB_URL} gdb-${GDB}"
    )
}

function setup_baremetal_default_buildfuncs() {
    BUILD_FUNCS=("build_binutils"
                 "build_gcc_stage_1"
                 "build_newlib"
                 "build_gcc_stage_2"
                 "build_gcc_final"
                 "build_gmp"
                 "build_gdb"
    )
}

function setup_linux_default_downloadfuncs() {
    DOWNLOAD_FUNCS=("fetch_source ${GLIBC_URL} glibc-${GLIBC}"
                    "fetch_source ${LINUX_URL} linux-${LINUX}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${GCC_URL} gcc-${GCC}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
                    "fetch_source ${CLOOG_URL} cloog-${CLOOG}"
                    "fetch_source ${GDB_URL} gdb-${GDB}"
    )
}

function setup_linux_default_buildfuncs() {
    BUILD_FUNCS=("build_binutils"
                 "build_headers"
                 "build_gcc_stage_1"
                 "build_glibc_header"
                 "build_gcc_stage_2"
                 "build_glibc"
                 "build_gcc_final"
                 "build_gmp"
                 "build_gdb"
    )
}

function setup_mingw_default_downloadfuncs() {
    DOWNLOAD_FUNCS=("fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${GCC_URL} gcc-${GCC}"
                    "fetch_source ${MINGW_URL} mingw-${MINGW}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
                    "fetch_source ${CLOOG_URL} cloog-${CLOOG}"
                    "fetch_source ${GDB_URL} gdb-${GDB}"
    )
}

function setup_mingw_default_buildfuncs() {
    BUILD_FUNCS=("build_binutils"
                 "build_mingw_header"
                 "build_gcc_stage_1"
                 "build_mingw_crt"
                 "build_mingw_winpthreads"
                 "build_gcc_final"
                 "build_gmp"
                 "build_gdb"
    )
}

# Source all target configs
for source_file in "${BASH_SOURCE%/*}"/targets/*.sh; do
    # shellcheck disable=SC1090
    source "$source_file"
done
