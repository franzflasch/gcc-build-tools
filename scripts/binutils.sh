#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_binutils() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "BUILDING BINUTILS"
    mkdir -p "${BUILD_DIR}/build-binutils"
    cd "${BUILD_DIR}/build-binutils" || die "ERROR: cd to ${BUILD_DIR}/build-binutils"
    call_cmd "${SOURCES_DIR}/binutils-${BINUTILS}/configure" "${BINUTILS_CONFIGURATION[@]}"
    call_cmd make "${JOBS}" all || die "Error while building binutils!" -n
    call_cmd make install || die "Error while installing binutils!" -n

    set_build_state "${FUNCNAME[0]}"
}

# needed for elf2flt
# this was taken from https://github.com/uclinux-dev/prebuilts-binutils-libs/blob/main/build.sh
function build_binutils_libs() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "BUILDING BFD"
    cd "${BUILD_DIR}/build-binutils" || die "ERROR: cd to ${BUILD_DIR}/build-binutils"
    call_cmd make "${JOBS}" all-bfd || die "Error while building target-bfd!" -n
    call_cmd make "${JOBS}" all-libiberty || die "Error while building target-libiberty!" -n

    mkdir -p "${INSTALL}"/bfd/{bfd,include/elf,libiberty}
    cp bfd/bfd.h bfd/libbfd.a "${INSTALL}"/bfd/bfd/

	if [[ -e bfd/bfd_stdint.h ]]; then
		# Binutils 2.32+ includes this header.
		cp bfd/bfd_stdint.h "${INSTALL}"/bfd/bfd/
	fi

    cp libiberty/libiberty.a "${INSTALL}"/bfd/libiberty/

	cp "${SOURCES_DIR}/binutils-${BINUTILS}"/include/{ansidecl,filenames,hashtab,libiberty,symcat}.h \
		"${INSTALL}"/bfd/include/

	if [[ -e "${SOURCES_DIR}/binutils-${BINUTILS}"/include/diagnostics.h ]]; then
		# Binutils 2.31+ includes this header.
		cp "${SOURCES_DIR}/binutils-${BINUTILS}"/include/diagnostics.h "${INSTALL}"/bfd/include/
	fi
    cp "${SOURCES_DIR}/binutils-${BINUTILS}"/include/elf/*.h "${INSTALL}"/bfd/include/elf/

    set_build_state "${FUNCNAME[0]}"
}
