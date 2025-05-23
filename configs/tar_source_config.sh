#!/usr/bin/env bash
# shellcheck disable=SC2034

function setup_urls_tar() {

    setup_common_urls_tar

    # Setup urls
    MPFR_URL="${MPFR_BASE_URL}${MPFR}.tar.xz;type=tar"
    GMP_URL="${GMP_BASE_URL}${GMP}.tar.xz;type=tar"
    MPC_URL="${MPC_BASE_URL}${MPC}.tar.gz;type=tar"
    ISL_URL="${ISL_BASE_URL}${ISL}.tar.xz;type=tar"

    BINUTILS_URL="${BINUTILS_BASE_URL}${BINUTILS}.tar.xz;type=tar"
    GCC_URL="${GCC_BASE_URL}${GCC}/${GCC}.tar.xz;type=tar"
    LINUX_URL="${LINUX_BASE_URL}${LINUX}.tar.xz;type=tar"
    GLIBC_URL="${GLIBC_BASE_URL}${GLIBC}.tar.xz;type=tar"
    NEWLIB_URL="${NEWLIB_BASE_URL}${NEWLIB}.tar.gz;type=tar"
    AVRLIBC_URL="${AVRLIBC_BASE_URL}${AVRLIBC}-release.tar.gz;type=tar"
    GDB_URL="${GDB_BASE_URL}${GDB}.tar.xz;type=tar"
    PICOLIBC_URL="${PICOLIBC_BASE_URL}${PICOLIBC}.tar.gz;type=tar"
    MINGW_URL="${MINGW_BASE_URL}${MINGW}.tar.gz;type=tar"
    UCLIBC_NG_URL="${UCLIBC_NG_BASE_URL}${UCLIBC_NG}/uClibc-ng-${UCLIBC_NG}.tar.xz;type=tar"
    ELF2FLT_URL="${ELF2FLT_BASE_URL}${ELF2FLT}.tar.gz;type=tar"
}

function setup_variables_tar_15() {
    MPFR="mpfr-4.2.2"
    GMP="gmp-6.3.0"
    MPC="mpc-1.3.1"
    ISL="isl-0.27"

    LINUX="6.12.28"
    GCC="gcc-15.1.0"
    BINUTILS="2.44"
    GLIBC="glibc-2.41"
    NEWLIB="newlib-4.5.0.20241231"
    AVRLIBC="avr-libc-2_2_1"
    GDB="gdb-16.3"
    PICOLIBC="1.8.10"
    MINGW="v12.0.0"
    UCLIBC_NG="1.0.52"
    ELF2FLT="v2024.05"

    setup_urls_tar
}

function setup_variables_tar_14() {
    MPFR="mpfr-4.2.1"
    GMP="gmp-6.3.0"
    MPC="mpc-1.3.1"
    ISL="isl-0.27"

    LINUX="6.8.9"
    GCC="gcc-14.2.0"
    BINUTILS="2.44"
    GLIBC="glibc-2.41"
    NEWLIB="newlib-4.5.0.20241231"
    AVRLIBC="avr-libc-2_2_1"
    GDB="gdb-16.1"
    PICOLIBC="1.8.9"
    MINGW="v12.0.0"
    UCLIBC_NG="1.0.51"
    ELF2FLT="v2024.05"

    setup_urls_tar
}

function setup_variables_tar_13() {
    MPFR="mpfr-4.2.1"
    GMP="gmp-6.3.0"
    MPC="mpc-1.3.1"
    ISL="isl-0.26"

    LINUX="6.1.45"
    GCC="gcc-13.2.0"
    BINUTILS="2.42"
    GLIBC="glibc-2.39"
    NEWLIB="newlib-4.4.0.20231231"
    AVRLIBC="avr-libc-2_1_0"
    GDB="gdb-14.1"
    PICOLIBC="1.8.6"
    MINGW="v11.0.1"
    UCLIBC_NG="1.0.45"
    ELF2FLT="v2024.02"

    setup_urls_tar
}

function setup_variables_tar_12() {
    MPFR="mpfr-4.2.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.3.1"
    ISL="isl-0.26"

    LINUX="6.1.26"
    GCC="gcc-12.3.0"
    BINUTILS="2.39"
    GLIBC="glibc-2.36"
    NEWLIB="newlib-4.2.0.20211231"
    AVRLIBC="avr-libc-2_1_0"
    GDB="gdb-12.1"
    PICOLIBC="1.8"
    MINGW="v10.0.0"
    UCLIBC_NG="1.0.43"
    ELF2FLT="v2021.08"

    setup_urls_tar

    PATCHES=(
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0001-elf2flt-handle-binutils-2.34.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0002-elf2flt.ld-reinstate-32-byte-alignment-for-.data-sec.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0003-elf2flt-add-riscv-64-bits-support.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0004-elf2flt-create-a-common-helper-function.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0005-elf2flt-fix-fatal-error-regression-on-m68k-xtensa-ri.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0006-elf2flt-xtensa-fix-text-relocations.patch"
    )
}

