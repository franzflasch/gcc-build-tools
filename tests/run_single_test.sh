#!/bin/bash

BASEDIR=$(dirname "$0")
ARCH_TO_BUILD="$1"
ENABLE_TAR_BUILD="$2"

docker_build_cmd="docker build --build-arg ARCH="$ARCH_TO_BUILD" --build-arg USE_TAR="$ENABLE_TAR_BUILD" -f "$BASEDIR"/dockerfile_debian10 --rm=true ."

$docker_build_cmd
IMAGE_ID=$($docker_build_cmd | awk '/Successfully built/{print $NF}')

docker rmi "$IMAGE_ID"
