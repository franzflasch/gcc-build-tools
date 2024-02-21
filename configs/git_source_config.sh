#!/usr/bin/env bash
# shellcheck disable=SC2034

function setup_urls_git() {

    setup_common_urls_git

    # Setup urls
    # Supported parameters:
    # type= - tar, git, svn
    # branch=
    # module= (only for svn) - will checkout a subfolder within the svn repo

    MPFR_URL="${MPFR_BASE_URL}${MPFR}.tar.xz;type=tar"
    GMP_URL="${GMP_BASE_URL}${GMP}.tar.xz;type=tar"
    MPC_URL="${MPC_BASE_URL}${MPC}.tar.gz;type=tar"
    ISL_URL="${ISL_BASE_URL}${ISL}.tar.xz;type=tar"

    BINUTILS_URL="${BINUTILS_GIT_URL};type=git;branch=${BINUTILS}"
    GCC_URL="${GCC_GIT_URL};type=git;branch=${GCC_BRANCH}"
    LINUX_URL="${LINUX_GIT_URL};type=git;branch=${LINUX}"

    GLIBC_URL="${GLIBC_GIT_URL};type=git;branch=${GLIBC_BRANCH}"

    NEWLIB_URL="${NEWLIB_GIT_URL};type=git;branch=${NEWLIB}"
    AVRLIBC_URL="${AVRLIBC_GIT_URL};type=git;branch=${AVRLIBC}"
    GDB_URL="${GDB_GIT_URL};type=git;branch=${GDB}"
    PICOLIBC_URL="${PICOLIBC_GIT_URL};type=git;branch=${PICOLIBC}"
    MINGW_URL="${MINGW_GIT_URL};type=git;branch=${MINGW}"
    UCLIBC_NG_URL="${UCLIBC_NG_GIT_URL};type=git;branch=${UCLIBC_NG}"
    ELF2FLT_URL="${ELF2FLT_GIT_URL};type=git;branch=${ELF2FLT}"
}

function setup_variables_git_master() {
    MPFR="mpfr-4.2.1"
    GMP="gmp-6.3.0"
    MPC="mpc-1.3.1"
    ISL="isl-0.26"

    BINUTILS="master"
    GLIBC="master"
    GLIBC_BRANCH="${GLIBC}"
    LINUX="master"
    GCC_BRANCH="master"
    GCC="master"
    NEWLIB="master"
    AVRLIBC="main"
    GDB="master"
    PICOLIBC="main"
    MINGW="master"

    setup_urls_git
}

function setup_variables_git_13() {
    MPFR="mpfr-4.2.1"
    GMP="gmp-6.3.0"
    MPC="mpc-1.3.1"
    ISL="isl-0.26"

    LINUX="v6.1"
    GCC="gcc-13"
    GCC_BRANCH="releases/${GCC}"
    BINUTILS="binutils-2_42-branch"

    GLIBC="glibc-2.39"
    GLIBC_BRANCH="${GLIBC}"

    NEWLIB="newlib-4.4.0"
    AVRLIBC="avr-libc-2_1_0-release"
    GDB="gdb-14.1-release"
    PICOLIBC="main"
    MINGW="v11.0.1"
    UCLIBC_NG="v1.0.45"
    ELF2FLT="v2024.02"

    setup_urls_git
}

function setup_variables_git_12() {
    MPFR="mpfr-4.2.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.3.1"
    ISL="isl-0.26"

    LINUX="v6.1"
    GCC="gcc-12"
    GCC_BRANCH="releases/${GCC}"
    BINUTILS="binutils-2_39-branch"

    GLIBC="glibc-2.36"
    GLIBC_BRANCH="${GLIBC}"

    NEWLIB="newlib-snapshot-20211231"
    AVRLIBC="avr-libc-2_1_0-release"
    GDB="gdb-12.1-release"
    PICOLIBC="main"
    MINGW="v10.0.0"
    UCLIBC_NG="v1.0.43"
    ELF2FLT="v2021.08"

    setup_urls_git

    PATCHES=(
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0001-elf2flt-handle-binutils-2.34.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0002-elf2flt.ld-reinstate-32-byte-alignment-for-.data-sec.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0003-elf2flt-add-riscv-64-bits-support.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0004-elf2flt-create-a-common-helper-function.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0005-elf2flt-fix-fatal-error-regression-on-m68k-xtensa-ri.patch"
        "elf2flt-${ELF2FLT} gcc12/elf2flt/0006-elf2flt-xtensa-fix-text-relocations.patch"
        # Fixes: https://sourceware.org/bugzilla/show_bug.cgi?id=29116
        "gdb-${GDB} gdb/fix-gdb-12-1-build.patch"
    )
}

function setup_variables_git_11() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.2.1"
    ISL="isl-0.24"

    LINUX="v5.15"
    GCC="gcc-11"
    GCC_BRANCH="releases/${GCC}"
    BINUTILS="binutils-2_38-branch"

    GLIBC="glibc-2.35"
    GLIBC_BRANCH="${GLIBC}"

    NEWLIB="newlib-snapshot-20211231"
    AVRLIBC="avr-libc-2_1_0-release"
    GDB="gdb-11-branch"
    PICOLIBC="main"
    MINGW="v10.0.0"

    setup_urls_git
}

function setup_variables_git_10() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.2.1"
    ISL="isl-0.23"

    LINUX="v5.10"
    GCC="gcc-10"
    GCC_BRANCH="releases/${GCC}"
    BINUTILS="binutils-2_36-branch"

    GLIBC="glibc-2.33"
    GLIBC_BRANCH="${GLIBC}"

    NEWLIB="newlib-4.1.0"
    AVRLIBC="avr-libc-2_0_0-release"
    GDB="gdb-10-branch"
    PICOLIBC="main"
    MINGW="v8.x"

    setup_urls_git
}
