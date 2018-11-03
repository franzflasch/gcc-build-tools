
function setup_urls_tar() {

    setup_common_urls_tar

    # Setup urls
    BINUTILS_URL="${BINUTILS_BASE_URL}${BINUTILS}.tar.xz"
    GCC_URL="${GCC_BASE_URL}${GCC}/${GCC}.tar.gz"
    LINUX_URL="${LINUX_BASE_URL}${LINUX}.tar.xz"
    GLIBC_URL="${GLIBC_BASE_URL}${GLIBC}.tar.xz"
    NEWLIB_URL="${NEWLIB_BASE_URL}${NEWLIB}.tar.gz"
    AVRLIBC_URL="${AVRLIBC_BASE_URL}${AVRLIBC}.tar.bz2"
    MPC_URL="${MPC_BASE_URL}${MPC}.tar.gz"
    ISL_URL="${ISL_BASE_URL}${ISL}.tar.xz"
    MPFR_URL="${MPFR_BASE_URL}${MPFR}.tar.xz"
    GMP_URL="${GMP_BASE_URL}${GMP}.tar.xz"
}

function setup_variables_tar_8() {
    # Linux
    LINUX="4.18"

    # GCC and Binutils
    GCC="gcc-8.2.0"

    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="2.31"

    # LIBC sources
    GLIBC="glibc-2.28"
    NEWLIB="newlib-3.0.0.20180831"
    AVRLIBC="avr-libc-2.0.0"

    setup_urls_tar
}

function setup_variables_tar_7() {
    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="2.31"
    GLIBC="glibc-2.28"
    LINUX="4.18"
    GCC="gcc-7.3.0"
    GCC_BASE_URL+="${GCC}/"
    NEWLIB="newlib-2.5.0.20171222"
    AVRLIBC="avr-libc-2.0.0"

    setup_urls_tar
}
