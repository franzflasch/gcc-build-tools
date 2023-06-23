#!/bin/bash

BASEDIR=$(dirname "$0")
ARCH_TO_BUILD="$1"
GCC_VERSION="$2"
ENABLE_TAR_BUILD="$3"
ENABLE_PACKAGE="$4"

docker_build_cmd="docker build --build-arg ARCH="$ARCH_TO_BUILD" --build-arg USE_TAR="$ENABLE_TAR_BUILD" --build-arg PACKAGE="$ENABLE_PACKAGE" --build-arg GCC_VERSION="$GCC_VERSION" -f "$BASEDIR"/dockerfile_ubuntu22_04 --rm=true ."

$docker_build_cmd
IMAGE_ID=$($docker_build_cmd | awk '/Successfully built/{print $NF}')

CONTAINER_ID=$(docker create ${IMAGE_ID})
docker cp ${CONTAINER_ID}:/home/toolchain_install .
docker rm ${CONTAINER_ID}

docker rmi "$IMAGE_ID"
