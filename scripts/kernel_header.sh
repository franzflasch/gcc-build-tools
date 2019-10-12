#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_headers() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING LINUX HEADERS"
    cd "${SOURCES_DIR}/linux-${LINUX}" || die "Linux kernel folder does not exist!"
    call_cmd make ARCH="${LINUX_ARCH}" \
        INSTALL_HDR_PATH="${INSTALL}/${TARGET}" \
        headers_install "${JOBS}" || die "Error while building/installing Linux headers!" -n

    set_build_state "${FUNCNAME[0]}"
}
