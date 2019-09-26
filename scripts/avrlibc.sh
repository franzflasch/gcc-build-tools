function build_avrlibc() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING AVRLIBC"

    # bootstrap fixup
    if [[ ! -f ${SOURCES_DIR}/avrlibc-${AVRLIBC}/configure ]]; then
        cd "${SOURCES_DIR}/avrlibc-${AVRLIBC}/"
        call_cmd ./bootstrap
        cd "${ROOT}"
    fi

    mkdir -p "${BUILD_DIR}/build-avrlibc"
    cd "${BUILD_DIR}/build-avrlibc" || die "avrlibc build folder does not exist!"
    call_cmd "${SOURCES_DIR}/avrlibc-${AVRLIBC}/configure" "${AVRLIBC_CONFIGURATION[@]}"
    call_cmd make || die "Error while building avrlibc!" -n
    call_cmd make install || die "Error while installing avrlibc!" -n

    set_build_state "${FUNCNAME[0]}"
}
