#!/usr/bin/env bash
# shellcheck disable=SC2034

function config_cortex-m0() {
    TARGET="arm-none-eabi" 

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
        "--with-cpu=cortex-m0"
        "--with-mode=thumb"
        "--enable-interwork"
        "--with-float=soft"
        "--disable-multilib"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-cpu=cortex-m0"
        "--with-mode=thumb"
        "--enable-interwork"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--without-headers"
        "--with-float=soft"
        "--disable-multilib"
    )

    NEWLIB_CONFIGURATION=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--with-cpu=cortex-m0"
        "--with-mode=thumb"
        "--enable-interwork"
        "--with-float=soft"
        "--disable-multilib"
        "--disable-newlib-supplied-syscalls"
        "--enable-newlib-reent-small"
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
        "--with-cpu=cortex-m0"
        "--with-mode=thumb"
        "--enable-interwork"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--with-float=soft"
        "--disable-multilib"
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

    DOWNLOAD_FUNCS=(
        "${DOWNLOAD_FUNCS[@]}"
        "fetch_source ${PICOLIBC_URL} picolibc-${PICOLIBC}"
    )

    BUILD_FUNCS=(
        "${BUILD_FUNCS[@]}"
        "build_picolibc"
    )
}
