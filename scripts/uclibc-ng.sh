#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_uclibc_ng() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "BUILDING UCLIBC-NG"
    cd "${SOURCES_DIR}/uclibc-ng-${UCLIBC_NG}" || die "ERROR: cd to ${SOURCES_DIR}/uclibc-ng-${UCLIBC_NG}"

    call_cmd "make distclean"

    touch .config

    $UCLIB_KCONFIG_CONFIGURATION

    # uncomment to be able to modify the config
    #call_cmd "make CROSS_COMPILE=${TARGET}- menuconfig"
    #call_cmd "make CROSS_COMPILE=${TARGET}- oldconfig"
    call_cmd "make CROSS_COMPILE=${TARGET}- olddefconfig"
    call_cmd "make CROSS_COMPILE=${TARGET}- UCLIBC_EXTRA_CFLAGS=' -g0 -fno-lto'"
    call_cmd "make CROSS_COMPILE=${TARGET}- PREFIX=${INSTALL}/${TARGET} UCLIBC_EXTRA_CFLAGS=' -g0 -fno-lto' install"

    set_build_state "${FUNCNAME[0]}"
}
