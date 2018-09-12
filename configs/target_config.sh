# These function here are more or less copy pasted for each architecture,
# which is usually a bad programming habit, however, it makes sense
# have a config function for each architecture, as it is possible
# to inject different architecure dependent configuration settings for the build here.

function setup_linux_default_config()
{
    IS_BARE_METAL=false

    # Configuration variables
    BINUTILS_CONFIGURATION=("--disable-nls"
                            "--disable-werror"
                            "--target=${TARGET}"
                            "--prefix=${INSTALL}")

    GCC_STAGE_1_CONFIGURATION=("--disable-libmpx" # Only for intel x86
                               "--disable-multilib"
                               "--enable-languages=c"
                               "--target=${TARGET}"
                               "--prefix=${INSTALL}")

    GLIBC_STAGE_1_CONFIGURATION=("--prefix=${INSTALL}/${TARGET}"
                                 "--with-headers=${INSTALL}/${TARGET}/include"
                                 "--host=${TARGET}"
                                 "--target=${TARGET}"
                                 "libc_cv_forced_unwind=yes"
                                 "libc_cv_c_cleanup=yes")

    GCC_STAGE_FINAL_CONFIGURATION=("--disable-libmpx" # Only for intel x86
		                           "--disable-multilib"
		                           "--enable-languages=c,c++"
		                           "--target=${TARGET}"
		                           "--prefix=${INSTALL}")
}


# default arm-linux-gnueabi
function config_arm-linux-gnueabi() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

    setup_linux_default_config

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}


function config_aarch64-linux-gnu() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

    setup_linux_default_config

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}


function config_i686-linux-gnu() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

    setup_linux_default_config

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}


function config_x86_64-linux-gnu() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

    setup_linux_default_config

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}


function config_arm-none-eabi() {
    local SOURCE="$1"
    local VERSION="$2"
    local TAR_OR_GIT="$3"

    IS_BARE_METAL=true

    # Configuration variables
    BINUTILS_CONFIGURATION=("--target=${TARGET}" 
                            "--prefix=${INSTALL}" 
                            "--disable-gdb"
                            "--with-cpu=cortex-m4"
                            "--with-fpu=fpv4-sp-d16"
                            "--with-float=hard"
                            "--with-mode=thumb"
                            "--enable-interwork"
                            "--enable-multilib"
                            "--with-gnu-as"
                            "--with-gnu-ld"
                            "--disable-nls")

    GCC_CONFIGURATION=("--target=${TARGET}"
                       "--prefix=${INSTALL}"
                       "--with-cpu=cortex-m4"
                       "--with-fpu=fpv4-sp-d16"
                       "--with-float=hard" 
                       "--with-mode=thumb"
                       "--enable-interwork"
                       "--enable-multilib"
                       "--enable-languages=c"
                       "--with-system-zlib"
                       "--with-newlib"
                       "--without-headers"
                       "--disable-shared"
                       "--disable-nls"
                       "--with-gnu-as"
                       "--with-gnu-ld")

    NEWLIB_CONFIGURATION=("--target=${TARGET}"
                          "--prefix=${INSTALL}"
                          "--with-cpu=cortex-m4"
                          "--with-fpu=fpv4-sp-d16"
                          "--with-float=hard" 
                          "--with-mode=thumb"
                          "--enable-interwork"
                          "--enable-multilib"
                          "--with-gnu-as"
                          "--with-gnu-ld"
                          "--disable-nls"
                          "--disable-newlib-supplied-syscalls")

    GCC_STAGE_2_CONFIGURATION=("--target=${TARGET}"
                               "--prefix=${INSTALL}"
                               "--with-cpu=cortex-m4"
                               "--with-fpu=fpv4-sp-d16"
                               "--with-float=hard" 
                               "--with-mode=thumb"
                               "--enable-interwork"
                               "--enable-multilib"
                               "--enable-languages=c"
                               "--with-system-zlib"
                               "--with-newlib"
                               "--disable-shared"
                               "--disable-nls"
                               "--with-gnu-as"
                               "--with-gnu-ld")

    type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}
