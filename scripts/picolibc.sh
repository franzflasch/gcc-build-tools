#!/usr/bin/env bash
# shellcheck disable=SC2034

function prepare_riscv32-none-elf_build() {
cat <<'EOF'  > "cross-riscv32-none-elf.txt"
[binaries]
c = 'riscv32-none-elf-gcc'
ar = 'riscv32-none-elf-ar'
as = 'riscv32-none-elf-as'
ld = 'riscv32-none-elf-ld'
strip = 'riscv32-none-elf-strip'

[host_machine]
system = 'none'
cpu_family = 'riscv'
cpu = 'riscv'
endian = 'little'
EOF
}

function prepare_arm-none-eabi_build() {
cat <<'EOF'  > "cross-arm-none-eabi.txt"
[binaries]
c = 'arm-none-eabi-gcc'
ar = 'arm-none-eabi-ar'
as = 'arm-none-eabi-as'
ld = 'arm-none-eabi-ld'
strip = 'arm-none-eabi-strip'

[host_machine]
system = 'none'
cpu_family = 'arm'
cpu = 'arm'
endian = 'little'
EOF
}

function build_picolibc() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING PICOLIBC"

    local picolibc_dir="${SOURCES_DIR}/picolibc-${PICOLIBC}"

    cd "${picolibc_dir}" || die "${picolibc_dir} folder does not exist!"

    type -t "prepare_${TARGET}_build" > /dev/null || die "No prepare_${TARGET}_build found!"
    "prepare_${TARGET}_build"

    mkdir -p "${BUILD_DIR}/build-picolibc"
    cd "${BUILD_DIR}/build-picolibc" || die "picolibc build folder does not exist!"
    call_cmd meson "${picolibc_dir}" -Dincludedir=picolibc/"${TARGET}"/include -Dlibdir=picolibc/"${TARGET}"/lib --cross-file "${picolibc_dir}"/cross-"${TARGET}".txt "${PICOLIBC_CONFIGURATION[@]}"

    call_cmd ninja || die "Error while building picolibc!" -n
    call_cmd ninja install || die "Error while installing picolibc!" -n

    # Install specs file
    sed -e "s|${PICOLIBC_INSTALL_DIR}||g" -i "${BUILD_DIR}"/build-picolibc/picolibc.specs
    cp "${BUILD_DIR}"/build-picolibc/picolibc.specs "${PICOLIBC_INSTALL_DIR}"

    set_build_state "${FUNCNAME[0]}"
}
