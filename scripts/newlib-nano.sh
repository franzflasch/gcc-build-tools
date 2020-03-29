#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_newlib_nano() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING NEWLIB NANO"

    mkdir -p "${BUILD_DIR}/build-newlib-nano"
    cd "${BUILD_DIR}/build-newlib-nano" || die "newlib-nano build folder does not exist!"
    call_cmd "${SOURCES_DIR}/newlib-${NEWLIB}/configure" "${NEWLIB_NANO_CONFIGURATION[@]}"
    call_cmd make all || die "Error while building newlib-nano!" -n
    call_cmd make install || die "Error while installing newlib-nano!" -n

    # Newlib nano specific preparations
    cd "${INSTALL}/${TARGET}/lib" || die "ERROR: cd to ${INSTALL}/${TARGET}/lib"
    rm -rf -- *_nano.a
    rm -rf -- *_nano.o

    for i in "${NEWLIB_NANO_INSTALL_DIR}"/arm-none-eabi/lib/*.a; do
	ln -s ../newlib-nano/arm-none-eabi/lib/"$(basename "$i")" "$(basename "$i" .a)"_nano.a
    done

    for i in "${NEWLIB_NANO_INSTALL_DIR}"/arm-none-eabi/lib/*.o; do
        ln -s ../newlib-nano/arm-none-eabi/lib/"$(basename "$i")" "$(basename "$i" .o)"_nano.o
    done

    # Now prepare the nano specs file
    cp "${NEWLIB_NANO_INSTALL_DIR}/${TARGET}/lib/nano.specs" .
    "${INSTALL}/bin/${TARGET}-gcc" -dumpspecs | grep "\\*startfile:" -A1 | sed 's/crt0/crt0_nano/g' >> nano.specs

    # Not sure if that is actually needed but the linaro buildscript does this also
    mkdir -p "${INSTALL}/${TARGET}/include/newlib-nano/"
    cp -f "${NEWLIB_NANO_INSTALL_DIR}/arm-none-eabi/include/newlib.h" "${INSTALL}/${TARGET}/include/newlib-nano/newlib.h"

    set_build_state "${FUNCNAME[0]}"
}
