
function setup_urls_tar() {

    setup_common_urls_tar

    # Setup urls
    BINUTILS_URL="${BINUTILS_BASE_URL}${BINUTILS}.tar.xz;type=tar"
    GCC_URL="${GCC_BASE_URL}${GCC}/${GCC}.tar.gz;type=tar"
    LINUX_URL="${LINUX_BASE_URL}${LINUX}.tar.xz;type=tar"
    GLIBC_URL="${GLIBC_BASE_URL}${GLIBC}.tar.xz;type=tar"
    NEWLIB_URL="${NEWLIB_BASE_URL}${NEWLIB}.tar.gz;type=tar"
    AVRLIBC_URL="${AVRLIBC_BASE_URL}${AVRLIBC}.tar.bz2;type=tar"
    MPC_URL="${MPC_BASE_URL}${MPC}.tar.gz;type=tar"
    ISL_URL="${ISL_BASE_URL}${ISL}.tar.xz;type=tar"
    MPFR_URL="${MPFR_BASE_URL}${MPFR}.tar.xz;type=tar"
    GMP_URL="${GMP_BASE_URL}${GMP}.tar.xz;type=tar"
}

function setup_variables_tar_8() {
    # Linux
    LINUX="4.20"

    # GCC and Binutils
    GCC="gcc-8.2.0"

    MPFR="mpfr-4.0.2"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="2.32"

    # LIBC sources
    GLIBC="glibc-2.29"
    NEWLIB="newlib-3.1.0.20181231"
    AVRLIBC="avr-libc-2.0.0"

    setup_urls_tar
}

function setup_variables_tar_7() {
    MPFR="mpfr-4.0.2"
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
