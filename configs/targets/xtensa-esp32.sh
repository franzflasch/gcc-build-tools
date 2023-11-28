#!/usr/bin/env bash
# shellcheck disable=SC2034

function config_xtensa-esp32() {
    TARGET="xtensa-esp32-elf" 

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
        "--with-cpu=esp32"
        "--with-float=soft"
        "--disable-multilib"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--without-headers"
        "--disable-multilib"
        "--disable-libssp"
    )

    NEWLIB_CONFIGURATION=(
        "${NEWLIB_BASE_CONFIGURATION[@]}"
        "--with-cpu=esp32"
        "--with-float=soft"
        "--disable-multilib"
        "--enable-newlib-io-long-long"
        "--enable-newlib-io-c99-formats"
        "--enable-newlib-register-fini"
        "--enable-newlib-retargetable-locking"
        "--disable-newlib-supplied-syscalls"
        "--disable-nls"
    )

    NEWLIB_NANO_CONFIGURATION=(
        "${NEWLIB_NANO_BASE_CONFIGURATION[@]}"
        "--with-cpu=esp32"
        "--with-float=soft"
        "--disable-multilib"
        "--disable-newlib-supplied-syscalls"
        "--enable-newlib-reent-small"
        "--enable-newlib-retargetable-locking"
        "--disable-newlib-fvwrite-in-streamio"
        "--disable-newlib-fseek-optimization"
        "--disable-newlib-wide-orient"
        "--enable-newlib-nano-malloc"
        "--disable-newlib-unbuf-stream-opt"
        "--enable-lite-exit"
        "--enable-newlib-global-atexit"
        "--enable-newlib-nano-formatted-io"
        "--disable-nls"
    )

    GCC_FINAL_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--disable-multilib"
        "--disable-libssp"
        "--enable-languages=c"
    )

    GDB_CONFIGURATION=(
        "${GDB_BASE_CONFIG[@]}"
    )

    PICOLIBC_INSTALL_DIR=${INSTALL}/${TARGET}/lib/
    PICOLIBC_CONFIGURATION=(
        "--prefix=${PICOLIBC_INSTALL_DIR}"
        "-Dthread-local-storage=false"
    )

    type -t "setup_variables_${TAR_OR_GIT}_${VERSION}" > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    "setup_variables_${TAR_OR_GIT}_${VERSION}"

    setup_baremetal_default_downloadfuncs
    setup_baremetal_default_buildfuncs

    DOWNLOAD_FUNCS=("fetch_source https://github.com/espressif/newlib-esp32/archive/refs/tags/esp-4.1.0_20230425.tar.gz;type=tar newlib-${NEWLIB}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${GCC_URL} gcc-${GCC}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
                    "fetch_source ${GDB_URL} gdb-${GDB}"
    )

    # DOWNLOAD_FUNCS=(
    #     "${DOWNLOAD_FUNCS[@]}"
    #     "fetch_source ${PICOLIBC_URL} picolibc-${PICOLIBC}"
    # )

    # BUILD_FUNCS=("build_binutils"
    #              "build_gcc_stage_1"
    #              "build_picolibc"
    #              "build_gcc_stage_2"
    #              "build_gcc_final"
    #              "build_gmp"
    #              "build_gdb"
    # )

    # BUILD_FUNCS=(
    #     "${BUILD_FUNCS[@]}"
    #     "build_newlib_nano"
    #     "build_picolibc"
    # )
}
