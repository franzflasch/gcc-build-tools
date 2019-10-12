#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_glibc_header() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GLIBC HEADERS"
    mkdir -p "${BUILD_DIR}/build-glibc"
    cd "${BUILD_DIR}/build-glibc" || die "glibc build folder does not exist!"
    call_cmd "${SOURCES_DIR}/glibc-${GLIBC}/configure" "${GLIBC_CONFIGURATION[@]}"

    call_cmd make install-bootstrap-headers=yes install-headers || die "Error while building glibc headers!" -n
    call_cmd make "${JOBS}" csu/subdir_lib || die "Error while building glibc headers 2!" -n
    call_cmd install csu/crt1.o csu/crti.o csu/crtn.o "${INSTALL}/${TARGET}/lib" || die "Error while installing crt" -n
    call_cmd "${INSTALL}/bin/${TARGET}-gcc" -nostdlib -nostartfiles -shared -x c /dev/null -o "${INSTALL}/${TARGET}/lib/libc.so" || die "Error while building libc" -n
    touch "${INSTALL}/${TARGET}/include/gnu/stubs.h"

    set_build_state "${FUNCNAME[0]}"
}

function build_glibc() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GLIBC"
    cd "${BUILD_DIR}/build-glibc" || die "glibc build folder does not exist!"
    call_cmd make "${JOBS}" || die "Error while building glibc"
    call_cmd make install || die "Error while installing glibc"

    set_build_state "${FUNCNAME[0]}"
}
