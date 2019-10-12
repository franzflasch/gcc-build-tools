#!/usr/bin/env bash
# shellcheck disable=SC2034

function config_x86() {
    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--disable-multilib"
        "--disable-libmpx"
    )

    GLIBC_CONFIGURATION=(
        "${GLIBC_BASE_CONFIG[@]}"
    )

    GDB_CONFIGURATION=(
        "${GDB_BASE_CONFIG[@]}"
    )

    type -t "setup_variables_${TAR_OR_GIT}_${VERSION}" > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    "setup_variables_${TAR_OR_GIT}_${VERSION}"

    setup_linux_default_downloadfuncs
    setup_linux_default_buildfuncs
}
