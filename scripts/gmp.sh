#!/usr/bin/env bash

function build_gmp() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GMP"

    mkdir -p "${BUILD_DIR}/build-gmp"
    cd "${BUILD_DIR}/build-gmp" || die "gmp build folder does not exist!"
    call_cmd "${SOURCES_DIR}/gmp-${GMP}/configure" "${GMP_BASE_CONFIG[@]}"
    call_cmd make || die "Error while building gmp!" -n
    call_cmd make install || die "Error while installing gmp!" -n

    set_build_state "${FUNCNAME[0]}"
}
