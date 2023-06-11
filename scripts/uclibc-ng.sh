#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_uclibc_ng() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "BUILDING UCLIBC-NG"
    #mkdir -p "${BUILD_DIR}/build-uclibc-ng"
    #cd "${BUILD_DIR}/build-uclibc-ng" || die "ERROR: cd to ${BUILD_DIR}/build-uclibc-ng"
    cd "${SOURCES_DIR}/uclibc-ng-${UCLIBC_NG}" || die "ERROR: cd to ${SOURCES_DIR}/uclibc-ng-${UCLIBC_NG}"
    
    call_cmd "make distclean"

    touch .config
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e TARGET_riscv64
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -d ARCH_USE_MMU

    # This is needed to be able to build libm
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_FLOATS
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_FPU
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e DO_C99_MATH
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_LONG_DOUBLE_MATH

    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k --set-str KERNEL_HEADERS "${INSTALL}/${TARGET}/include"
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_EXTRA_COMPAT_RES_STATE
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -e UCLIBC_HAS_RESOLVER_SUPPORT
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k --set-str RUNTIME_PREFIX ""
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k --set-str DEVEL_PREFIX ""
    CONFIG_="" "${TOOLS_ROOT_DIR}"/ext/scripts/config -k -d HARDWIRED_ABSPATH

    #call_cmd "make CROSS_COMPILE=${TARGET}- defconfig"
    
    # uncomment to be able to modify the config
    # call_cmd "make CROSS_COMPILE=${TARGET}- menuconfig"
    
    call_cmd "make CROSS_COMPILE=${TARGET}- oldconfig"
    call_cmd "make CROSS_COMPILE=${TARGET}-"
    call_cmd "make CROSS_COMPILE=${TARGET}- PREFIX=${INSTALL}/${TARGET} install"

    set_build_state "${FUNCNAME[0]}"
}
