function build_newlib() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING NEWLIB"

    mkdir -p "${BUILD_DIR}/build-newlib"
    cd "${BUILD_DIR}/build-newlib" || die "newlib build folder does not exist!"
    call_cmd "${SOURCES_DIR}/newlib-${NEWLIB}/configure" "${NEWLIB_CONFIGURATION[@]}"
    call_cmd make all || die "Error while building newlib!" -n
    call_cmd make install || die "Error while installing newlib!" -n

    set_build_state "${FUNCNAME[0]}"
}
