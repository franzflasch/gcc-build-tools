
function setup_base_urls_git_gnu() {

    setup_common_urls_git

    GCC_GIT_URL="git://gcc.gnu.org/git/gcc.git"
}

function setup_base_urls_git_linaro() {

    setup_common_urls_git

    GCC_GIT_URL="https://git.linaro.org/toolchain/gcc.git"
}

function setup_variables_git_gnu_9() {

    setup_base_urls_git_gnu

    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="binutils-2_31-branch"
    GLIBC="glibc-2.28"
    LINUX="v4.18"
    GCC="master"
}

function setup_variables_git_gnu_8() {

    setup_base_urls_git_gnu

    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="binutils-2_31-branch"
    GLIBC="glibc-2.28"
    LINUX="v4.18"
    GCC="gcc-8-branch"
    NEWLIB="newlib-3.0.0"
}

function setup_variables_git_gnu_7() {

    setup_base_urls_git_gnu

    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="binutils-2_31-branch"
    GLIBC="glibc-2.28"
    LINUX="v4.18"
    GCC="gcc-7-branch"
    NEWLIB="newlib-2.5.0"
}

function setup_variables_git_linaro_7() {

    setup_base_urls_git_linaro

    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="binutils-2_31-branch"
    GLIBC="glibc-2.28"
    LINUX="v4.18"
    GCC="linaro-local/gcc-7-integration-branch"
    NEWLIB="newlib-2_5_0"
}

function setup_variables_git_linaro_6() {

    setup_base_urls_git_linaro

    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="binutils-2_31-branch"
    GLIBC="glibc-2.28"
    LINUX="v4.18"
    GCC="linaro-local/gcc-6-integration-branch"
    NEWLIB="newlib-2_4_0"
}
