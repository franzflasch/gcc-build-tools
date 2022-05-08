#!/usr/bin/env bash
# shellcheck disable=SC2034

function setup_common_urls() {
    MPFR_BASE_URL="https://ftp.gnu.org/gnu/mpfr/"
    GMP_BASE_URL="https://ftp.gnu.org/gnu/gmp/"
    MPC_BASE_URL="https://ftp.gnu.org/gnu/mpc/"
    ISL_BASE_URL="https://libisl.sourceforge.io/"
    CLOOG_BASE_URL="http://www.bastoul.net/cloog/pages/download/"
}

function setup_common_urls_tar() {

    setup_common_urls

    BINUTILS_BASE_URL="https://ftp.gnu.org/gnu/binutils/binutils-"
    GCC_BASE_URL="ftp://ftp.fu-berlin.de/unix/languages/gcc/releases/"
    GLIBC_BASE_URL="https://ftp.gnu.org/gnu/glibc/"
    LINUX_BASE_URL="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-"
    NEWLIB_BASE_URL="ftp://sourceware.org/pub/newlib/"
    AVRLIBC_BASE_URL="https://github.com/avrdudes/avr-libc/archive/refs/tags/"
    GDB_BASE_URL="http://ftp.gnu.org/gnu/gdb/"
    PICOLIBC_BASE_URL="https://github.com/keith-packard/picolibc/archive/"
    MINGW_BASE_URL="https://github.com/mirror/mingw-w64/archive/refs/tags/"
}

function setup_common_urls_git() {

    setup_common_urls

    BINUTILS_GIT_URL="git://sourceware.org/git/binutils-gdb.git"
    GCC_GIT_URL="git://gcc.gnu.org/git/gcc.git"
    GLIBC_GIT_URL="git://sourceware.org/git/glibc.git"
    LINUX_GIT_URL="git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
    NEWLIB_GIT_URL="git://sourceware.org/git/newlib-cygwin.git"
    AVRLIBC_GIT_URL="https://github.com/avrdudes/avr-libc.git"
    GDB_GIT_URL="git://sourceware.org/git/binutils-gdb.git"
    PICOLIBC_GIT_URL="https://github.com/keith-packard/picolibc.git"
    MINGW_GIT_URL="https://github.com/mirror/mingw-w64.git"
}
