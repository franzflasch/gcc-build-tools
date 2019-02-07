# These function here are more or less copy pasted for each architecture,
# which is usually a bad programming habit, however, it makes sense
# have a config function for each architecture, as it is possible
# to inject different architecure dependent configuration settings for the build here.

function setup_default_config()
{
    # Configuration variables
    BINUTILS_BASE_CONFIG=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--disable-nls"
        "--disable-werror"
    )

    GCC_BASE_CONFIG=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--disable-nls"
        "--enable-languages=c"
    )

    GLIBC_BASE_CONFIG=(
        "CC=${TARGET}-gcc"
        "CXX=${TARGET}-g++"
        "--host=${TARGET}"
        "--prefix=${INSTALL}/${TARGET}"
        "--with-headers=${INSTALL}/${TARGET}/include"
    )
}

function setup_baremetal_default_downloadfuncs() {
    DOWNLOAD_FUNCS=("fetch_source ${NEWLIB_URL} newlib-${NEWLIB}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${GCC_URL} gcc-${GCC}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
    )
}

function setup_baremetal_default_buildfuncs() {
    BUILD_FUNCS=("build_binutils"
                 "build_gcc_stage_1"
                 "build_newlib"
                 "build_gcc_final"
    )
}

function setup_linux_default_downloadfuncs() {
    DOWNLOAD_FUNCS=("fetch_source ${GLIBC_URL} glibc-${GLIBC}"
                    "fetch_source ${LINUX_URL} linux-${LINUX}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${GCC_URL} gcc-${GCC}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
                    "fetch_source ${CLOOG_URL} cloog-${CLOOG}"
    )
}

function setup_linux_default_buildfuncs() {
    BUILD_FUNCS=("build_binutils"
                 "build_headers"
                 "build_gcc_stage_1"
                 "build_glibc_header"
                 "build_gcc_stage2"
                 "build_glibc"
                 "build_gcc_final"
    )
}

# default arm-linux-gnueabi
function config_arm-linux-gnueabi_arm() {
    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
    )

    GLIBC_CONFIGURATION=(
        "${GLIBC_BASE_CONFIG[@]}"
    )

    type -t setup_variables_${TAR_OR_GIT}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${VERSION}

    setup_linux_default_downloadfuncs
    setup_linux_default_buildfuncs
}


function config_aarch64-linux-gnu_arm64() {
    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
    )
    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
    )
    GLIBC_CONFIGURATION=(
        "${GLIBC_BASE_CONFIG[@]}"
    )

    type -t setup_variables_${TAR_OR_GIT}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${VERSION}

    setup_linux_default_downloadfuncs
    setup_linux_default_buildfuncs
}


function config_i686-linux-gnu_x86() {
    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--disable-multilib"
        "--disable-libmpx"
    )

    GLIBC_CONFIGURATION=(
        "${GLIBC_BASE_CONFIG[@]}"
    )

    type -t setup_variables_${TAR_OR_GIT}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${VERSION}

    setup_linux_default_downloadfuncs
    setup_linux_default_buildfuncs
}


function config_x86_64-linux-gnu_x86_64() {
    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--disable-multilib"
    )

    GLIBC_CONFIGURATION=(
        "${GLIBC_BASE_CONFIG[@]}"
    )

    type -t setup_variables_${TAR_OR_GIT}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${VERSION}

    setup_linux_default_downloadfuncs
    setup_linux_default_buildfuncs
}


function config_arm-none-eabi_cm4f() {
    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
        "--with-cpu=cortex-m3"
        "--with-mode=thumb"
        "--enable-interwork"
        "--disable-gdb"
        "--with-fpu=fpv4-sp-d16"
        "--with-float=hard"
        "--enable-multilib"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-cpu=cortex-m3"
        "--with-mode=thumb"
        "--enable-interwork"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--without-headers"
        "--with-fpu=fpv4-sp-d16"
        "--with-float=hard"
        "--enable-multilib"
    )

    NEWLIB_CONFIGURATION=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--with-cpu=cortex-m3"
        "--with-mode=thumb"
        "--enable-interwork"
        "--disable-nls"
        "--disable-newlib-supplied-syscalls"
        "--with-fpu=fpv4-sp-d16"
        "--with-float=hard"
        "--enable-multilib"
    )

    GCC_FINAL_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-cpu=cortex-m3"
        "--with-mode=thumb"
        "--enable-interwork"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--with-fpu=fpv4-sp-d16"
        "--with-float=hard"
        "--enable-multilib"
        "--enable-languages=c,c++"
    )

    type -t setup_variables_${TAR_OR_GIT}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${VERSION}

    setup_baremetal_default_downloadfuncs
    setup_baremetal_default_buildfuncs
}

function config_riscv32-none-elf_riscv-baremetal() {
    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
        "--with-arch=rv32ima"
        "--with-abi=ilp32"
        "--disable-gdb"
        "--enable-multilib"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-arch=rv32ima"
        "--with-abi=ilp32"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--without-headers"
        "--enable-multilib"
    )

    NEWLIB_CONFIGURATION=(
        "--target=${TARGET}"
        "--prefix=${INSTALL}"
        "--with-arch=rv32ima"
        "--with-abi=ilp32"
        "--disable-nls"
        "--disable-newlib-supplied-syscalls"
        "--enable-multilib"
    )

    GCC_FINAL_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--with-arch=rv32ima"
        "--with-abi=ilp32"
        "--with-system-zlib"
        "--with-newlib"
        "--disable-shared"
        "--enable-multilib"
        "--enable-languages=c,c++"
    )

    type -t setup_variables_${TAR_OR_GIT}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${VERSION}

    setup_baremetal_default_downloadfuncs
    setup_baremetal_default_buildfuncs
}

function config_avr_avr8() {
    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
        "--disable-gdb"
    )

    GCC_CONFIGURATION=(
        "${GCC_BASE_CONFIG[@]}"
        "--disable-libssp"
        "--disable-libada"
        "--with-dwarf2"
        "--disable-shared"
        "--enable-static"
    )

    AVRLIBC_CONFIGURATION=(
        "--host=${TARGET}"
        "--prefix=${INSTALL}"
    )

    type -t setup_variables_${TAR_OR_GIT}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${VERSION}

    DOWNLOAD_FUNCS=("fetch_source ${AVRLIBC_URL} avrlibc-${AVRLIBC}"
                    "fetch_source ${BINUTILS_URL} binutils-${BINUTILS}"
                    "fetch_source ${GCC_URL} gcc-${GCC} ${GCC}"
                    "fetch_source ${MPC_URL} mpc-${MPC}"
                    "fetch_source ${ISL_URL} isl-${ISL}"
                    "fetch_source ${MPFR_URL} mpfr-${MPFR}"
                    "fetch_source ${GMP_URL} gmp-${GMP}"
    )

    BUILD_FUNCS=("build_binutils"
                 "build_gcc_stage_1"
                 "build_avrlibc"
                 "build_gcc_final"
    )
}
