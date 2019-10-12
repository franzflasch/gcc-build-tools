#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_picolibc() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING PICOLIBC"

    mkdir -p "${BUILD_DIR}/build-picolibc"
    cd "${BUILD_DIR}/build-picolibc" || die "picolibc build folder does not exist!"
    call_cmd "${SOURCES_DIR}/picolibc-${PICOLIBC}/do-${PICOLIBC_ARCH}-configure" "${PICOLIBC_CONFIGURATION[@]}"
    call_cmd ninja || die "Error while building picolibc!" -n
    call_cmd ninja install || die "Error while installing picolibc!" -n

    # Install specs file
    sed -e "s|${PICOLIBC_INSTALL_DIR}||g" -i "${BUILD_DIR}"/build-picolibc/picolibc.specs
    cp "${BUILD_DIR}"/build-picolibc/picolibc.specs "${PICOLIBC_INSTALL_DIR}"

    set_build_state "${FUNCNAME[0]}"
}
