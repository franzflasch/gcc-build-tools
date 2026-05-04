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
    MPC_URL="${MPC_BASE_URL}${MPC}.tar.xz;type=tar"
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
    MPFR="mpfr-4.2.2"
    GMP="gmp-6.3.0"
    MPC="mpc-1.3.1"
    ISL="isl-0.27"

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

function setup_variables_git_16() {
    MPFR="mpfr-4.2.2"
    GMP="gmp-6.3.0"
    MPC="mpc-1.4.1"
    ISL="isl-0.27"

    LINUX="v6.18.26"
    GCC="gcc-16"
    GCC_BRANCH="releases/${GCC}"
    BINUTILS="binutils-2_46-branch"

    GLIBC="glibc-2.43"
    GLIBC_BRANCH="${GLIBC}"

    NEWLIB="newlib-4.6.0"
    AVRLIBC="avr-libc-2_3_1-release"
    GDB="gdb-17.1-release"
    PICOLIBC="main"
    MINGW="v14.0.0"
    UCLIBC_NG="v1.0.57"
    ELF2FLT="v2024.05"

    setup_urls_git

    # Patches can be added here if needed, e.g.:
    # PATCHES=(
    #     "elf2flt-${ELF2FLT} gcc16/elf2flt/0001-some-fix.patch"
    #     "gdb-${GDB} gdb/fix-gdb-16-build.patch"
    # )
}

function setup_variables_git_15() {
    MPFR="mpfr-4.2.2"
    GMP="gmp-6.3.0"
    MPC="mpc-1.4.1"
    ISL="isl-0.27"

    LINUX="v6.18.26"
    GCC="gcc-15"
    GCC_BRANCH="releases/${GCC}"
    BINUTILS="binutils-2_46-branch"

    GLIBC="glibc-2.43"
    GLIBC_BRANCH="${GLIBC}"

    NEWLIB="newlib-4.6.0"
    AVRLIBC="avr-libc-2_3_1-release"
    GDB="gdb-17.1-release"
    PICOLIBC="main"
    MINGW="v14.0.0"
    UCLIBC_NG="v1.0.57"
    ELF2FLT="v2024.05"

    setup_urls_git
}

function setup_variables_git_14() {
    MPFR="mpfr-4.2.1"
    GMP="gmp-6.3.0"
    MPC="mpc-1.3.1"
    ISL="isl-0.27"

    LINUX="v6.8"
    GCC="gcc-14"
    GCC_BRANCH="releases/${GCC}"
    BINUTILS="binutils-2_44-branch"

    GLIBC="glibc-2.41"
    GLIBC_BRANCH="${GLIBC}"

    NEWLIB="newlib-4.5.0"
    AVRLIBC="avr-libc-2_2_1-release"
    GDB="gdb-16.1-release"
    PICOLIBC="main"
    MINGW="v12.0.0"
    UCLIBC_NG="v1.0.51"
    ELF2FLT="v2024.05"

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

