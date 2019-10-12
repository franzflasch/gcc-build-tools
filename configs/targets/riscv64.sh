#!/usr/bin/env bash
# shellcheck disable=SC2034

function config_riscv64() {
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
        "--enable-languages=c,c++"
    )
    GLIBC_CONFIGURATION=(
        "${GLIBC_BASE_CONFIG[@]}"
        "--with-arch=rv64imafdc"
        "--with-abi=lp64d"
        "--with-tune=rocket"
        "--disable-multilib"
    )

    GDB_CONFIGURATION=(
        "${GDB_BASE_CONFIG[@]}"
    )

    type -t "setup_variables_${TAR_OR_GIT}_${VERSION}" > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    "setup_variables_${TAR_OR_GIT}_${VERSION}"

    setup_linux_default_downloadfuncs
    setup_linux_default_buildfuncs
}
