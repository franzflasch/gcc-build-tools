#!/usr/bin/env bash
# shellcheck disable=SC2034

function config_riscv64-baremetal() {
    TARGET="riscv64-none-elf" 

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
        "--with-arch=rv64ima"
        "--with-abi=lp64"
        "--enable-multilib"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-arch=rv64ima"
        "--with-abi=lp64"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--without-headers"
        "--enable-multilib"
    )

    NEWLIB_CONFIGURATION=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--with-arch=rv64ima"
        "--with-abi=lp64"
        "--disable-nls"
        "--disable-newlib-supplied-syscalls"
        "--enable-multilib"
    )

    GCC_FINAL_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-arch=rv64ima"
        "--with-abi=lp64"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--enable-multilib"
        "--enable-languages=c,c++"
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
}
