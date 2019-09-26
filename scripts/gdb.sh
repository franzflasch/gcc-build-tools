function build_gdb() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GDB"

    mkdir -p "${BUILD_DIR}/build-gdb"
    cd "${BUILD_DIR}/build-gdb" || die "gdb build folder does not exist!"
    call_cmd "${SOURCES_DIR}/gdb-${GDB}/configure" "${GDB_CONFIGURATION[@]}"
    call_cmd make || die "Error while building gdb!" -n
    call_cmd make install || die "Error while installing gdb!" -n

    set_build_state "${FUNCNAME[0]}"
}
