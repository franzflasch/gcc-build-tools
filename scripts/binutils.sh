function build_binutils() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}"
    # use clean hashtable
    hash -r

    header "BUILDING BINUTILS"
    mkdir -p "${BUILD_DIR}/build-binutils"
    cd "${BUILD_DIR}/build-binutils"
    call_cmd "${SOURCES_DIR}/binutils-${BINUTILS}/configure" "${BINUTILS_CONFIGURATION[@]}"
    call_cmd make ${JOBS} all || die "Error while building binutils!" -n
    call_cmd make install || die "Error while installing binutils!" -n

    set_build_state "${FUNCNAME[0]}"
}
