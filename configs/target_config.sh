# These function here are more or less copy pasted for each architecture,
# which is usually a bad programming habit, however, it makes sense
# have a config function for each architecture, as it is possible
# to inject different architecure dependent configuration settings for the build here.

# default arm-linux-gnueabi
function config_arm-linux-gnueabi() {
	local SOURCE="$1"
	local VERSION="$2"
	local TAR_OR_GIT="$3"

	type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}

function config_aarch64-linux-gnu() {
	local SOURCE="$1"
	local VERSION="$2"
	local TAR_OR_GIT="$3"

	type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}

function config_i686-linux-gnu() {
	local SOURCE="$1"
	local VERSION="$2"
	local TAR_OR_GIT="$3"

	type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}

function config_x86_64-linux-gnu() {
	local SOURCE="$1"
	local VERSION="$2"
	local TAR_OR_GIT="$3"

	type -t setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION} found!"
    setup_variables_${TAR_OR_GIT}_${SOURCE}_${VERSION}
}
