
function setup_base_urls_tar_gnu() {

    setup_common_urls_tar

    GCC_BASE_URL="https://mirrors.kernel.org/gnu/gcc/"  
}

function setup_base_urls_tar_linaro() {

    setup_common_urls_tar

    GCC_BASE_URL="https://git.linaro.org/toolchain/gcc.git/snapshot/"  
}

function setup_variables_tar_gnu_8() {

    setup_base_urls_tar_gnu

    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="2.31"
    GLIBC="glibc-2.28"
    LINUX="4.18"
    GCC="gcc-8.2.0"
    GCC_BASE_URL+="${GCC}/"
    NEWLIB="newlib-3.0.0.20180831"
}

function setup_variables_tar_gnu_7() {

    setup_base_urls_tar_gnu

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
}

function setup_variables_tar_linaro_7() {

    setup_base_urls_tar_linaro

    MPFR="mpfr-4.0.1"
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="2.31"
    GLIBC="glibc-2.28"
    LINUX="4.18"
    GCC="gcc-linaro-snapshot-7.3-2018.06"
    NEWLIB="newlib-2.5.0.20171222"
}

function setup_variables_tar_linaro_6() {

    setup_base_urls_tar_linaro

    MPFR="mpfr-4.0.1"    
    GMP="gmp-6.1.2"
    MPC="mpc-1.1.0"
    ISL="isl-0.18"
    BINUTILS="2.31"
    GLIBC="glibc-2.28"
    LINUX="4.18"
    GCC="gcc-linaro-snapshot-6.4-2018.06"
    NEWLIB="newlib-2.4.0.20161025"
}
