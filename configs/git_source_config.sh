
function setup_urls_git() {

    setup_common_urls_git

    # Setup urls
    BINUTILS_URL="${BINUTILS_GIT_URL}"
    GCC_URL="${GCC_GIT_URL}"
    LINUX_URL="${LINUX_GIT_URL}"
    GLIBC_URL="${GLIBC_GIT_URL}"
    NEWLIB_URL="${NEWLIB_GIT_URL}"
    MPC_URL="${MPC_BASE_URL}${MPC}.tar.gz"
    ISL_URL="${ISL_BASE_URL}${ISL}.tar.xz"
    MPFR_URL="${MPFR_BASE_URL}${MPFR}.tar.xz"
    GMP_URL="${GMP_BASE_URL}${GMP}.tar.xz"
}

function setup_variables_git_9() {
    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="binutils-2_31-branch"
    GLIBC="glibc-2.28"
    LINUX="v4.18"
    GCC="master"

    setup_urls_git
}

function setup_variables_git_8() {
    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="binutils-2_31-branch"
    GLIBC="glibc-2.28"
    LINUX="v4.18"
    GCC="gcc-8-branch"
    NEWLIB="newlib-3.0.0"

    setup_urls_git
}

function setup_variables_git_7() {
    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="binutils-2_31-branch"
    GLIBC="glibc-2.28"
    LINUX="v4.18"
    GCC="gcc-7-branch"
    NEWLIB="newlib-2.5.0"

    setup_urls_git
}
