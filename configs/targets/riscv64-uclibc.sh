#!/usr/bin/env bash
# shellcheck disable=SC2034

function setup_linux_uclibc_downloadfuncs() {
    DOWNLOAD_FUNCS=("fetch_source ${LINUX_URL} linux-${LINUX}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${ELF2FLT_URL} elf2flt-${ELF2FLT}"
                    "fetch_source ${GCC_URL} gcc-${GCC}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
                    "fetch_source ${CLOOG_URL} cloog-${CLOOG}"
                    "fetch_source ${UCLIBC_NG_URL} uclibc-ng-${UCLIBC_NG}"
    )
}

function setup_linux_uclibc_buildfuncs() {
    BUILD_FUNCS=("build_binutils"
                 "build_binutils_libs"
                 "build_elf2flt"
                 "build_headers"
                 "build_gcc_stage_1"
                 "build_gcc_stage_2"
                 "build_uclibc_ng"
                 "build_gcc_final"
    )
}

function riscv64-uclibc_kconfig() 
{
    #call_cmd "make CROSS_COMPILE=${TARGET}- defconfig"

    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e TARGET_riscv64
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -d ARCH_USE_MMU

    # This is needed to be able to build libm
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_FLOATS
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_FPU
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e DO_C99_MATH
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_LONG_DOUBLE_MATH

    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k --set-str KERNEL_HEADERS "${INSTALL}/${TARGET}/include"
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_EXTRA_COMPAT_RES_STATE
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_RESOLVER_SUPPORT
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k --set-str RUNTIME_PREFIX ""
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k --set-str DEVEL_PREFIX ""
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -d HARDWIRED_ABSPATH

    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_UTMPX
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_UTMP
}

function config_riscv64-uclibc() {
    TARGET="riscv64-linux-uclibc"
    # shellcheck disable=SC2034
    LINUX_ARCH="riscv"

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    if [[ "$VERSION" = "13" ]]; then
        die "ERROR: gcc 13 is not supported, yet!"
    fi

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
        "--with-arch=rv64imafd"
        "--with-abi=lp64"
        "--disable-multilib"
    )

    ELF2FLT_CONFIGURATION=(
        "${ELF2FLT_BASE_CONFIG[@]}"
        "--target=riscv64-linux-uclibc"
    )

    # Config is loosely based on buildroot
    GCC_CONFIGURATION=(
        "CFLAGS_FOR_TARGET='-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os -g0  -fPIC  -Wl,-elf2flt=-r -static'"
        "CXXFLAGS_FOR_TARGET='-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os -g0  -fPIC  -Wl,-elf2flt=-r -static  -Wl,-elf2flt=-r -static'"
        "${GCC_BASE_CONFIG[@]}"
        "--with-arch=rv64imafd"
        "--with-abi=lp64"
        "--disable-multilib"
        "--disable-threads"
        "--disable-shared"
        "--disable-libatomic"
        "--disable-libgomp"
        "--without-headers"
        "--with-newlib"
        "--disable-largefile"
        "--disable-libsanitizer"
        "--disable-tls"
        "--disable-decimal-float"
        "--disable-libssp"
        "--enable-__cxa_atexit"
    )

    # Config is loosely based on buildroot
    GCC_FINAL_CONFIGURATION=(
        "CFLAGS_FOR_TARGET='-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os -g0  -fPIC  -Wl,-elf2flt=-r -static'"
        "CXXFLAGS_FOR_TARGET='-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os -g0  -fPIC  -Wl,-elf2flt=-r -static  -Wl,-elf2flt=-r -static'"
        "${GCC_BASE_CONFIG[@]}"
        "--with-arch=rv64imafd"
        "--with-abi=lp64"
        "--enable-static"
        "--disable-multilib"
        "--disable-threads"
        "--disable-shared"
        "--disable-libatomic"
        "--disable-libgomp"
        "--disable-largefile"
        "--disable-libsanitizer"
        "--disable-tls"
        "--disable-decimal-float"
        "--disable-libssp"
        "--enable-__cxa_atexit"
    )

    UCLIB_KCONFIG_CONFIGURATION=riscv64-uclibc_kconfig

    type -t "setup_variables_${TAR_OR_GIT}_${VERSION}" > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    "setup_variables_${TAR_OR_GIT}_${VERSION}"

    setup_linux_uclibc_downloadfuncs
    setup_linux_uclibc_buildfuncs
}
