#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_elf2flt() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "BUILDING ELF2FLT"
    mkdir -p "${BUILD_DIR}/build-elf2flt"
    cd "${BUILD_DIR}/build-elf2flt" || die "ERROR: cd to ${BUILD_DIR}/build-elf2flt"
    call_cmd "${SOURCES_DIR}/elf2flt-${ELF2FLT}/configure" "${ELF2FLT_CONFIGURATION[@]}"
    call_cmd make "${JOBS}"

    call_cmd make "${JOBS}" install

    set_build_state "${FUNCNAME[0]}"
}
