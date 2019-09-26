function build_gcc_stage_1() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GCC STAGE 1"

    ln -sfn "${SOURCES_DIR}/mpfr-${MPFR}" "${SOURCES_DIR}/gcc-${GCC}/mpfr"
    ln -sfn "${SOURCES_DIR}/gmp-${GMP}" "${SOURCES_DIR}/gcc-${GCC}/gmp"
    ln -sfn "${SOURCES_DIR}/mpc-${MPC}" "${SOURCES_DIR}/gcc-${GCC}/mpc"
    ln -sfn "${SOURCES_DIR}/isl-${ISL}" "${SOURCES_DIR}/gcc-${GCC}/isl"
    ln -sfn "${SOURCES_DIR}/cloog-${CLOOG}" "${SOURCES_DIR}/gcc-${GCC}/cloog"

    mkdir -p "${BUILD_DIR}/build-gcc"
    cd "${BUILD_DIR}/build-gcc" || die "GCC build folder does not exist!"
    call_cmd "${SOURCES_DIR}/gcc-${GCC}/configure" "${GCC_CONFIGURATION[@]}"
    call_cmd make ${JOBS} all-gcc || die "Error while building gcc stage1!" -n
    call_cmd make ${JOBS} install-gcc || die "Error while installing gcc stage1!" -n

    set_build_state "${FUNCNAME[0]}"
}

function build_gcc_stage2() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GCC STAGE 2"

    mkdir -p "${BUILD_DIR}/build-gcc"
    cd "${BUILD_DIR}/build-gcc" || die "GCC build folder does not exist!"
    call_cmd make ${JOBS} all-target-libgcc || die "Error while building gcc stage2" -n
    call_cmd make install-target-libgcc || die "Error while building gcc stage2" -n

    set_build_state "${FUNCNAME[0]}"
}

function build_gcc_final() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GCC FINAL"
    cd "${BUILD_DIR}/build-gcc" || die "GCC build folder does not exist!"

    # We need to reconfigure if there is a final config available
    if [[ ! -z "${GCC_FINAL_CONFIGURATION[@]}" ]]; then
       call_cmd "${SOURCES_DIR}/gcc-${GCC}/configure" "${GCC_FINAL_CONFIGURATION[@]}"
    fi

    call_cmd make ${JOBS} all || die "Error while building gcc final" -n
    call_cmd make install || die "Error while gcc final install" -n

    set_build_state "${FUNCNAME[0]}"
}
