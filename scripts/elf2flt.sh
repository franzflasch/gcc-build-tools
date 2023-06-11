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
    call_cmd make "${JOBS}" || die "Error while building elf2flt!" -n

    # taken from: http://instrumentacion.qi.fcen.uba.ar/paralel1/www.beyondlogic.org/uClinux/gcc-2.95.3.pdf
    # (old but still applicable it seems)
    #cp elf2flt ${INSTALL}/${TARGET}/bin
    #cp elf2flt.ld ${INSTALL}/${TARGET}/lib
    
    #mv ${INSTALL}/bin/${TARGET}-ld ${INSTALL}/bin/${TARGET}-ld.real
    #mv ${INSTALL}/${TARGET}/bin/ld ${INSTALL}/${TARGET}/bin/ld.real

    #cp ld-elf2flt ${INSTALL}/bin/${TARGET}-ld
    #cp ld-elf2flt ${INSTALL}/${TARGET}/ld

    call_cmd make "${JOBS}" install || die "Error while installing elf2flt!" -n

    set_build_state "${FUNCNAME[0]}"
}
