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
    call_cmd "make CROSS_COMPILE=${TARGET}- menuconfig"
    call_cmd "make CROSS_COMPILE=${TARGET}- oldconfig"
    call_cmd "make CROSS_COMPILE=${TARGET}-"
    call_cmd "make CROSS_COMPILE=${TARGET}- PREFIX=${INSTALL}/${TARGET} install"
    #call_cmd "${SOURCES_DIR}/uclibg-ng-${UCLIBC_NG}/configure" "${BINUTILS_CONFIGURATION[@]}"
    #call_cmd make "${JOBS}" all || die "Error while building binutils!" -n
    #call_cmd make install || die "Error while installing binutils!" -n

    set_build_state "${FUNCNAME[0]}"
}
