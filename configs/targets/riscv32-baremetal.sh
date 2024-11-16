#!/usr/bin/env bash
# shellcheck disable=SC2034

function config_riscv32-baremetal() {
    TARGET="riscv32-none-elf"

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

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
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--without-headers"
        "--disable-multilib"
    )

    NEWLIB_CONFIGURATION=(
    "${NEWLIB_BASE_CONFIGURATION[@]}"
        "--with-arch=rv32ima"
        "--with-abi=ilp32"
        "--disable-nls"
        "--disable-newlib-supplied-syscalls"
        "--disable-multilib"
    )

    NEWLIB_NANO_CONFIGURATION=(
        "${NEWLIB_NANO_BASE_CONFIGURATION[@]}"
        "--with-arch=rv32ima"
        "--with-abi=ilp32"
        "--disable-nls"
        "--disable-newlib-supplied-syscalls"
        "--disable-multilib"
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
    )

    GCC_FINAL_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-arch=rv32ima"
        "--with-abi=ilp32"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--disable-multilib"
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

    DOWNLOAD_FUNCS=(
        "${DOWNLOAD_FUNCS[@]}"
        "fetch_source ${PICOLIBC_URL} picolibc-${PICOLIBC}"
    )

    BUILD_FUNCS=(
        "${BUILD_FUNCS[@]}"
        "build_newlib_nano"
        "build_picolibc"
    )
}
