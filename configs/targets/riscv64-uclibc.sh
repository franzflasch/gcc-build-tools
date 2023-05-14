#!/usr/bin/env bash
# shellcheck disable=SC2034

function setup_linux_uclibc_downloadfuncs() {
    DOWNLOAD_FUNCS=("fetch_source ${LINUX_URL} linux-${LINUX}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
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
                 "build_headers"
                 "build_gcc_stage_1"
                 "build_gcc_stage2"
                 "build_uclibc_ng"
                 "build_gcc_final"
    )
}

function config_riscv64-uclibc() {
    TARGET="riscv64-linux-uclibc"
    # shellcheck disable=SC2034
    LINUX_ARCH="riscv"

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
        "--with-arch=rv64imafdc"
        "--with-abi=lp64d"
        "--with-tune=rocket"
        "--disable-multilib"
    )
    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-arch=rv64imafdc"
        "--with-abi=lp64d"
        "--with-tune=rocket"
        "--disable-multilib"
        "--disable-threads"
        "--disable-nls"
        "--disable-shared"
        "--disable-libmudflap"
        "--disable-libssp" 
        "--disable-libgomp"
        "--disable-libquadmath"
        "--disable-target-libiberty"
        "--disable-target-zlib"
        "--disable-decimal-float"
    )
    GDB_CONFIGURATION=(
        "${GDB_BASE_CONFIG[@]}"
    )

    type -t "setup_variables_${TAR_OR_GIT}_${VERSION}" > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    "setup_variables_${TAR_OR_GIT}_${VERSION}"

    setup_linux_uclibc_downloadfuncs
    setup_linux_uclibc_buildfuncs
}
