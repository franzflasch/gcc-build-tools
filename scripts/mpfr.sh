#!/usr/bin/env bash

function build_mpfr() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING MPFR"

    mkdir -p "${BUILD_DIR}/build-mpfr"
    cd "${BUILD_DIR}/build-mpfr" || die "mpfr build folder does not exist!"
    call_cmd "${SOURCES_DIR}/mpfr-${MPFR}/configure" "${MPFR_BASE_CONFIG[@]}"
    call_cmd make || die "Error while building MPFR!" -n
    call_cmd make install || die "Error while installing MPFR!" -n

    set_build_state "${FUNCNAME[0]}"
}
