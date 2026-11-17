#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_gcc_stage_1() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GCC STAGE 1"

    ln -sfn "${SOURCES_DIR}/mpfr-${MPFR}" "${SOURCES_DIR}/gcc-${GCC}/mpfr"
    ln -sfn "${SOURCES_DIR}/gmp-${GMP}" "${SOURCES_DIR}/gcc-${GCC}/gmp"
    ln -sfn "${SOURCES_DIR}/mpc-${MPC}" "${SOURCES_DIR}/gcc-${GCC}/mpc"
    ln -sfn "${SOURCES_DIR}/isl-${ISL}" "${SOURCES_DIR}/gcc-${GCC}/isl"

    mkdir -p "${BUILD_DIR}/build-gcc"
    cd "${BUILD_DIR}/build-gcc" || die "GCC build folder does not exist!"
    call_cmd "${SOURCES_DIR}/gcc-${GCC}/configure" "${GCC_CONFIGURATION[@]}"
    call_cmd make "${JOBS}" all-gcc
    call_cmd make "${JOBS}" install-gcc

    set_build_state "${FUNCNAME[0]}"
}

function build_gcc_stage_2() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GCC STAGE 2"

    mkdir -p "${BUILD_DIR}/build-gcc"
    cd "${BUILD_DIR}/build-gcc" || die "GCC build folder does not exist!"
    call_cmd make "${JOBS}" all-target-libgcc
    call_cmd make install-target-libgcc

    set_build_state "${FUNCNAME[0]}"
}

function build_gcc_final() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GCC FINAL"
    cd "${BUILD_DIR}/build-gcc" || die "GCC build folder does not exist!"

    # We need to reconfigure if there is a final config available
    if [[ -n "${GCC_FINAL_CONFIGURATION[*]}" ]]; then
       call_cmd "${SOURCES_DIR}/gcc-${GCC}/configure" "${GCC_FINAL_CONFIGURATION[@]}"
    fi

    call_cmd make "${JOBS}" all
    call_cmd make install

    set_build_state "${FUNCNAME[0]}"
}
