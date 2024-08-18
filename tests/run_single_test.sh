#!/bin/bash

BASEDIR=$(dirname "$0")
ARCH_TO_BUILD="$1"
GCC_VERSION="$2"
ENABLE_TAR_BUILD="$3"
ENABLE_PACKAGE="$4"

docker build -t docker_image_$ARCH_TO_BUILD --build-arg ARCH="$ARCH_TO_BUILD" --build-arg USE_TAR="$ENABLE_TAR_BUILD" --build-arg PACKAGE="$ENABLE_PACKAGE" --build-arg GCC_VERSION="$GCC_VERSION" -f "$BASEDIR"/dockerfile_ubuntu24_04 --rm=true .

CONTAINER_ID=$(docker create docker_image_$ARCH_TO_BUILD)
docker cp ${CONTAINER_ID}:/home/toolchain_install .
docker rm ${CONTAINER_ID}

docker rmi "docker_image_$ARCH_TO_BUILD"
