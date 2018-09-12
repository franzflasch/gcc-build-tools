# These function here are more or less copy pasted for each architecture,
# which is usually a bad programming habit, however, it makes sense
# have a config function for each architecture, as it is possible
# to inject different architecure dependent configuration settings for the build here.

function setup_default_config()
{
    IS_BARE_METAL=false

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
        "--host=${TARGET}"
        "--target=${TARGET}"
        "--prefix=${INSTALL}/${TARGET}"
        "--with-headers=${INSTALL}/${TARGET}/include"
        "libc_cv_forced_unwind=yes"
        "libc_cv_c_cleanup=yes"
    )
}


# default arm-linux-gnueabi
function config_arm-linux-gnueabi_arm() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

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

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}


function config_aarch64-linux-gnu_arm64() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

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

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}


function config_i686-linux-gnu_x86() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

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

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}


function config_x86_64-linux-gnu_x86-64() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

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

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}


function config_arm-none-eabi_cm4f() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

    setup_default_config

    IS_BARE_METAL=true

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

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}

