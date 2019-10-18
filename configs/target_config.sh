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
    )

    GCC_BASE_CONFIG=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--disable-nls"
        "--enable-languages=c"
    )

    GLIBC_BASE_CONFIG=(
        "CC=${TARGET}-gcc"
        "CXX=${TARGET}-g++"
        "--host=${TARGET}"
        "--prefix=${INSTALL}/${TARGET}"
        "--with-headers=${INSTALL}/${TARGET}/include"
    )

    GDB_BASE_CONFIG=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--disable-binutils"
        "--disable-ld"
        "--disable-gas"
        "--with-expat"
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
                 "build_gcc_final"
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
                 "build_gcc_stage2"
                 "build_glibc"
                 "build_gcc_final"
                 "build_gdb"
    )
}

# Source all target configs
for source_file in "${BASH_SOURCE%/*}"/targets/*.sh; do
    # shellcheck disable=SC1090
    source "$source_file"
done
