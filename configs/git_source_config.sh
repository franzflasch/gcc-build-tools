
function setup_urls_git() {

    setup_common_urls_git

    # Setup urls
    BINUTILS_URL="${BINUTILS_GIT_URL};type=git;branch=${BINUTILS}"
    GCC_URL="${GCC_GIT_URL};type=git;branch=${GCC}"
    LINUX_URL="${LINUX_GIT_URL};type=git;branch=${LINUX}"
    GLIBC_URL="${GLIBC_GIT_URL};type=git;branch=${GLIBC}"
    NEWLIB_URL="${NEWLIB_GIT_URL};type=git;branch=${NEWLIB}"
    AVRLIBC_URL="${AVRLIBC_SVN_URL};type=svn;branch=${AVRLIBC};module=${AVRLIBC_MODULE}"
    MPC_URL="${MPC_BASE_URL}${MPC}.tar.gz;type=tar"
    ISL_URL="${ISL_BASE_URL}${ISL}.tar.xz;type=tar"
    MPFR_URL="${MPFR_BASE_URL}${MPFR}.tar.xz;type=tar"
    GMP_URL="${GMP_BASE_URL}${GMP}.tar.xz;type=tar"
    CLOOG_URL="${CLOOG_BASE_URL}${CLOOG}.tar.gz;type=tar"
}

function setup_variables_git_master() {
    MPFR="mpfr-4.0.2"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.20"
    CLOOG="cloog-0.18.4"
    BINUTILS="master"
    GLIBC="master" # May produces a compilation error, should work with glibc-2.28
    LINUX="master"
    GCC="master"
    NEWLIB="master"
    AVRLIBC="trunk"
    AVRLIBC_MODULE="/avr-libc"

    setup_urls_git
}

function setup_variables_git_8() {
    MPFR="mpfr-4.0.2"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    CLOOG="cloog-0.18.4"
    BINUTILS="binutils-2_32-branch"
    GLIBC="glibc-2.29"
    LINUX="v4.20"
    GCC="gcc-8-branch"
    NEWLIB="newlib-3.1.0"
    AVRLIBC="tags"
    AVRLIBC_MODULE="/avr-libc-2_0_0-release"

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
    AVRLIBC="tags"
    AVRLIBC_MODULE="/avr-libc-2_0_0-release"

    setup_urls_git
}
