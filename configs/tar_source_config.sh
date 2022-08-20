#!/usr/bin/env bash
# shellcheck disable=SC2034

function setup_urls_tar() {

    setup_common_urls_tar

    # Setup urls
    MPFR_URL="${MPFR_BASE_URL}${MPFR}.tar.xz;type=tar"
    GMP_URL="${GMP_BASE_URL}${GMP}.tar.xz;type=tar"
    MPC_URL="${MPC_BASE_URL}${MPC}.tar.gz;type=tar"
    ISL_URL="${ISL_BASE_URL}${ISL}.tar.xz;type=tar"
    CLOOG_URL="${CLOOG_BASE_URL}${CLOOG}.tar.gz;type=tar"

    BINUTILS_URL="${BINUTILS_BASE_URL}${BINUTILS}.tar.xz;type=tar"
    GCC_URL="${GCC_BASE_URL}${GCC}/${GCC}.tar.xz;type=tar"
    LINUX_URL="${LINUX_BASE_URL}${LINUX}.tar.xz;type=tar"
    GLIBC_URL="${GLIBC_BASE_URL}${GLIBC}.tar.xz;type=tar"
    NEWLIB_URL="${NEWLIB_BASE_URL}${NEWLIB}.tar.gz;type=tar"
    AVRLIBC_URL="${AVRLIBC_BASE_URL}${AVRLIBC}-release.tar.gz;type=tar"
    GDB_URL="${GDB_BASE_URL}${GDB}.tar.xz;type=tar"
    PICOLIBC_URL="${PICOLIBC_BASE_URL}${PICOLIBC}.tar.gz;type=tar"
    MINGW_URL="${MINGW_BASE_URL}${MINGW}.tar.gz;type=tar"
}

function setup_variables_tar_12() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.2.1"
    ISL="isl-0.24"
    CLOOG="cloog-0.18.4"

    LINUX="5.15.6"
    GCC="gcc-12.2.0"
    BINUTILS="2.39"
    GLIBC="glibc-2.36"
    NEWLIB="newlib-4.2.0.20211231"
    AVRLIBC="avr-libc-2_1_0"
    GDB="gdb-12.1"
    PICOLIBC="1.7.8"
    MINGW="v10.0.0"

    setup_urls_tar
}

function setup_variables_tar_11() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.2.1"
    ISL="isl-0.24"
    CLOOG="cloog-0.18.4"

    LINUX="5.15.6"
    GCC="gcc-11.2.0"
    BINUTILS="2.38"
    GLIBC="glibc-2.35"
    NEWLIB="newlib-4.2.0.20211231"
    AVRLIBC="avr-libc-2_1_0"
    GDB="gdb-11.2"
    PICOLIBC="1.7.6"
    MINGW="v10.0.0"

    setup_urls_tar

#    PATCHES=(
#        "mingw-${MINGW} mingw/mingw64-runtime-8.0.0-__rdtsc.patch"
#    )
}

function setup_variables_tar_10() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.2.1"
    ISL="isl-0.23"
    CLOOG="cloog-0.18.4"

    LINUX="5.10.5"
    GCC="gcc-10.3.0"
    BINUTILS="2.36.1"
    GLIBC="glibc-2.33"
    NEWLIB="newlib-4.1.0"
    AVRLIBC="avr-libc-2_0_0"
    GDB="gdb-10.2"
    PICOLIBC="1.5.1"
    MINGW="v8.0.0"

    setup_urls_tar
}

function setup_variables_tar_9() {
    LINUX="5.1"
    GCC="gcc-9.3.0"
    BINUTILS="2.34"
    GLIBC="glibc-2.31"
    MPFR="mpfr-4.0.2"
    GMP="gmp-6.2.0"
    MPC="mpc-1.1.0"
    ISL="isl-0.22.1"
    CLOOG="cloog-0.18.4"
    NEWLIB="newlib-3.3.0"
    AVRLIBC="avr-libc-2_0_0"
    GDB="gdb-9.1"
    PICOLIBC="1.4.1"
    MINGW="v7.0.0"

    setup_urls_tar
}
