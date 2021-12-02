#!/usr/bin/env bash
# shellcheck disable=SC2034

function config_avr8() {
    TARGET="avr" 

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--disable-libssp"
        "--disable-libada"
        "--with-dwarf2"
        "--disable-shared"
        "--enable-static"
    )

    AVRLIBC_CONFIGURATION=(
        "--host=${TARGET}"
        "--prefix=${INSTALL}"
    )

    GDB_CONFIGURATION=(
        "${GDB_BASE_CONFIG[@]}"
    )

    type -t "setup_variables_${TAR_OR_GIT}_${VERSION}" > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    "setup_variables_${TAR_OR_GIT}_${VERSION}"

    DOWNLOAD_FUNCS=("fetch_source ${AVRLIBC_URL} avrlibc-${AVRLIBC}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${GCC_URL} gcc-${GCC} ${GCC}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
                    "fetch_source ${GDB_URL} gdb-${GDB}"
    )

    BUILD_FUNCS=("build_binutils"
                 "build_gcc_stage_1"
                 "build_avrlibc"
                 "build_gcc_final"
                 "build_gmp"
                 "build_gdb"
    )
}
