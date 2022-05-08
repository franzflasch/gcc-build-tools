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

    GLIBC_URL="${GLIBC_GIT_URL};type=git;branch=${GLIBC_BRANCH}"

    NEWLIB_URL="${NEWLIB_GIT_URL};type=git;branch=${NEWLIB}"
    AVRLIBC_URL="${AVRLIBC_GIT_URL};type=git;branch=${AVRLIBC}"
    GDB_URL="${GDB_GIT_URL};type=git;branch=${GDB}"
    PICOLIBC_URL="${PICOLIBC_GIT_URL};type=git;branch=${PICOLIBC}"
    MINGW_URL="${MINGW_GIT_URL};type=git;branch=${MINGW}"
}

function setup_variables_git_master() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.2.1"
    ISL="isl-0.24"
    CLOOG="cloog-0.18.4"

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

function setup_variables_git_11() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.2.1"
    ISL="isl-0.24"
    CLOOG="cloog-0.18.4"

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

#    PATCHES=(
#        "mingw-${MINGW} mingw/mingw64-runtime-8.0.0-__rdtsc.patch"
#    )
}

function setup_variables_git_10() {
    MPFR="mpfr-4.1.0"
    GMP="gmp-6.2.1"
    MPC="mpc-1.2.1"
    ISL="isl-0.23"
    CLOOG="cloog-0.18.4"

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
    AVRLIBC="avr-libc-2_0_0-release"
    GDB="gdb-8.2-branch"
    PICOLIBC="main"

    setup_urls_git
}
