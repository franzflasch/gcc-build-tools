#!/usr/bin/env bash
# shellcheck disable=SC2034

function setup_linux_uclibc32_downloadfuncs() {
    DOWNLOAD_FUNCS=("fetch_source ${LINUX_URL} linux-${LINUX}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${GCC_URL} gcc-${GCC}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
                    "fetch_source ${UCLIBC_NG_URL} uclibc-ng-${UCLIBC_NG}"
    )
}

function setup_linux_uclibc32_buildfuncs() {
    BUILD_FUNCS=("build_binutils"
                 "build_headers"
                 "build_gcc_stage_1"
                 "build_gcc_stage_2"
                 "build_uclibc_ng"
                 "build_gcc_final"
    )
}

function config_riscv32-uclibc() {
    TARGET="riscv32-linux-uclibc"
    # shellcheck disable=SC2034
    LINUX_ARCH="riscv"

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
        "--with-arch=rv32ima"
        "--with-abi=ilp32"
        "--disable-multilib"
    )
    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-arch=rv32ima"
        "--with-abi=ilp32"
        "--disable-multilib"
        "--disable-threads"
        "--without-headers"
        "--disable-shared"
    )
    GDB_CONFIGURATION=(
        "${GDB_BASE_CONFIG[@]}"
    )

    type -t "setup_variables_${TAR_OR_GIT}_${VERSION}" > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    "setup_variables_${TAR_OR_GIT}_${VERSION}"

    setup_linux_uclibc32_downloadfuncs
    setup_linux_uclibc32_buildfuncs
}
