#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_mingw_header() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING MINGW HEADERS"
    mkdir -p "${BUILD_DIR}/build-mingw-headers"
    cd "${BUILD_DIR}/build-mingw-headers" || die "build-mingw-headers folder does not exist!"
    call_cmd "${SOURCES_DIR}/mingw-${MINGW}/mingw-w64-headers/configure" "${MINGW_HEADER_CONFIGURATION[@]}"

    call_cmd make install || die "Error while building mingw headers!" -n

    set_build_state "${FUNCNAME[0]}"
}

function build_mingw_crt() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING MINGW CRT"
    mkdir -p "${BUILD_DIR}/build-mingw-crt"
    cd "${BUILD_DIR}/build-mingw-crt" || die "build-mingw-crt folder does not exist!"
    call_cmd "${SOURCES_DIR}/mingw-${MINGW}/configure" "${MINGW_CRT_CONFIGURATION[@]}"
    call_cmd make "${JOBS}" || die "Error while building mingw-crt"
    call_cmd make install || die "Error while installing mingw-crt"

    set_build_state "${FUNCNAME[0]}"
}

function build_mingw_winpthreads() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING MINGW WINPTHREADS"
    mkdir -p "${BUILD_DIR}/build-mingw-winpthreads"
    cd "${BUILD_DIR}/build-mingw-winpthreads" || die "build-mingw-winpthreads folder does not exist!"
    call_cmd "${SOURCES_DIR}/mingw-${MINGW}/mingw-w64-libraries/winpthreads/configure" "${MINGW_WINPTHREADS_CONFIGURATION[@]}"
    call_cmd make "${JOBS}" || die "Error while building mingw-winpthreads"
    call_cmd make install || die "Error while installing mingw-winpthreads"

    set_build_state "${FUNCNAME[0]}"
}
