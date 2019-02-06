
function setup_urls_tar() {

    setup_common_urls_tar

    # Setup urls
    BINUTILS_URL="${BINUTILS_BASE_URL}${BINUTILS}.tar.xz;type=tar"
    GCC_URL="${GCC_BASE_URL}${GCC}/${GCC}.tar.xz;type=tar"
    LINUX_URL="${LINUX_BASE_URL}${LINUX}.tar.xz;type=tar"
    GLIBC_URL="${GLIBC_BASE_URL}${GLIBC}.tar.xz;type=tar"
    NEWLIB_URL="${NEWLIB_BASE_URL}${NEWLIB}.tar.gz;type=tar"
    AVRLIBC_URL="${AVRLIBC_BASE_URL}${AVRLIBC}.tar.bz2;type=tar"
    MPC_URL="${MPC_BASE_URL}${MPC}.tar.gz;type=tar"
    ISL_URL="${ISL_BASE_URL}${ISL}.tar.xz;type=tar"
    MPFR_URL="${MPFR_BASE_URL}${MPFR}.tar.xz;type=tar"
    GMP_URL="${GMP_BASE_URL}${GMP}.tar.xz;type=tar"
    CLOOG_URL="${CLOOG_BASE_URL}${CLOOG}.tar.gz;type=tar"
}

function setup_variables_tar_8() {
    LINUX="4.20"
    GCC="gcc-8.2.0"
    BINUTILS="2.32"
    GLIBC="glibc-2.29"
    MPFR="mpfr-4.0.2"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18" # GCC 8 only builds with isl-0.20 so far
    CLOOG="cloog-0.18.4"
    NEWLIB="newlib-3.1.0.20181231"
    AVRLIBC="avr-libc-2.0.0"

    setup_urls_tar
}

function setup_variables_tar_7() {
    LINUX="4.20"
    GCC="gcc-7.4.0"
    BINUTILS="2.32"
    GLIBC="glibc-2.29"
    MPFR="mpfr-4.0.2"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.20"
    CLOOG="cloog-0.18.4"
    NEWLIB="newlib-2.5.0.20171222"
    AVRLIBC="avr-libc-2.0.0"

    setup_urls_tar
}
