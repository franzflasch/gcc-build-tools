#!/usr/bin/env bash
# shellcheck disable=SC2034

function config_x86_64_mingw() {
    TARGET="x86_64-w64-mingw32" 

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
    )

    MINGW_HEADER_CONFIGURATION=(
        "${MINGW_HEADER_BASE_CONFIG[@]}"
    )

    MINGW_CRT_CONFIGURATION=(
        "${MINGW_CRT_BASE_CONFIG[@]}"
    )

    MINGW_WINPTHREADS_CONFIGURATION=(
        "${MINGW_WINPTHREADS_BASE_CONFIG[@]}"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--enable-fully-dynamic-string"
        "--enable-checking=release"
        "--enable-version-specific-runtime-libs"
        "--disable-shared"
        "--disable-multilib"
        "--disable-nls"
        "--disable-werror"
        "--disable-win32-registry"
        "--disable-sjlj-exceptions"
        "--disable-libstdcxx-verbose"
        "--enable-threads=posix"
    )

    type -t "setup_variables_${TAR_OR_GIT}_${VERSION}" > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    "setup_variables_${TAR_OR_GIT}_${VERSION}"

    setup_mingw_default_downloadfuncs
    setup_mingw_default_buildfuncs
}
