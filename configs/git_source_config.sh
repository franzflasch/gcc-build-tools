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
    CLOOG_URL="${CLOOG_BASE_URL}${CLOOG}.tar.gz;type=tar"

    BINUTILS_URL="${BINUTILS_GIT_URL};type=git;branch=${BINUTILS}"
    GCC_URL="${GCC_GIT_URL};type=git;branch=${GCC_BRANCH}"
    LINUX_URL="${LINUX_GIT_URL};type=git;branch=${LINUX}"

    # Set back to this after release of 2.32
    #GLIBC_URL="${GLIBC_GIT_URL};type=git;branch=${GLIBC}"
    GLIBC_URL="${GLIBC_GIT_URL};type=git;branch=${GLIBC_BRANCH}"

    NEWLIB_URL="${NEWLIB_GIT_URL};type=git;branch=${NEWLIB}"
    AVRLIBC_URL="${AVRLIBC_SVN_URL};type=svn;branch=${AVRLIBC_BRANCH}"
    GDB_URL="${GDB_GIT_URL};type=git;branch=${GDB}"
    PICOLIBC_URL="${PICOLIBC_GIT_URL};type=git;branch=${PICOLIBC}"
    MINGW_URL="${MINGW_GIT_URL};type=git;branch=${MINGW}"
}

function setup_variables_git_master() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.0"
    MPC="mpc-1.1.0"
    ISL="isl-0.22.1"
    CLOOG="cloog-0.18.4"

    BINUTILS="master"
    GLIBC="master"
    LINUX="master"
    GCC_BRANCH="master"
    GCC="master"
    NEWLIB="master"
    AVRLIBC="trunk/avr-libc"
    GDB="master"
    PICOLIBC="main"

    setup_urls_git
}

function setup_variables_git_10() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.0"
    MPC="mpc-1.1.0"
    ISL="isl-0.22.1"
    CLOOG="cloog-0.18.4"

    LINUX="v5.6"
    GCC="gcc-10"
    GCC_BRANCH="releases/${GCC}"
    BINUTILS="binutils-2_34-branch"

    # Use the current 2.31 release master branch instead of the release tag
    # because of https://sourceware.org/pipermail/glibc-cvs/2020q1/069150.html
    # PLEASE set to GLIBC="glibc-2.32" as soon as it is released
    GLIBC="glibc-2.31"
    GLIBC_BRANCH="release/2.31/master"

    NEWLIB="newlib-3.3.0"
    AVRLIBC="avr-libc-2_0_0-release"
    AVRLIBC_BRANCH="tags/${AVRLIBC}"
    GDB="gdb-9-branch"
    PICOLIBC="main"
    MINGW="v7.x"

    setup_urls_git
}

function setup_variables_git_9() {
    MPFR="mpfr-4.0.2"
    GMP="gmp-6.2.0"
    MPC="mpc-1.1.0"
    ISL="isl-0.22.1"
    CLOOG="cloog-0.18.4"
    BINUTILS="binutils-2_34-branch"
    GLIBC="glibc-2.31"
    LINUX="v5.1"
    GCC="gcc-9"
    GCC_BRANCH="releases/${GCC}"
    NEWLIB="newlib-3.3.0"
    AVRLIBC="avr-libc-2_0_0-release"
    AVRLIBC_BRANCH="tags/${AVRLIBC}"
    GDB="gdb-9-branch"
    PICOLIBC="main"
    MINGW="v7.x"

    setup_urls_git
}

function setup_variables_git_8() {
    MPFR="mpfr-4.0.2"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.21"
    CLOOG="cloog-0.18.4"
    BINUTILS="binutils-2_32-branch"
    GLIBC="glibc-2.29"
    LINUX="v5.1"
    GCC="gcc-8-branch"
    NEWLIB="newlib-3.1.0"
    AVRLIBC="tags/avr-libc-2_0_0-release"
    GDB="gdb-8.2-branch"
    PICOLIBC="main"

    setup_urls_git
}

function setup_variables_git_7() {
    MPFR="mpfr-4.0.2"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.20"
    CLOOG="cloog-0.18.4"
    BINUTILS="binutils-2_32-branch"
    GLIBC="glibc-2.29"
    LINUX="v4.20"
    GCC="gcc-7-branch"
    NEWLIB="newlib-2.5.0"
    AVRLIBC="tags/avr-libc-2_0_0-release"
    GDB="gdb-7.12-branch"
    PICOLIBC="main"

    setup_urls_git
}
