#!/bin/bash

BASEDIR=$(dirname "$0")

docker build -f "$BASEDIR"/dockerfile_debian10 --rm=true .
IMAGE_ID=$(docker build -f "$BASEDIR"/dockerfile_debian10 --rm=true . | awk '/Successfully built/{print $NF}')

docker rmi "$IMAGE_ID"

RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a arm64 -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a avr8 -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a cortex-m0 -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a cortex-m3 -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a riscv32-baremetal -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a riscv64-baremetal -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a riscv64 -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a x86 -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a x86_64 -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a x86_mingw -v 9 $USE_TAR && rm -rf /home/work_dir/*"
RUN /bin/bash -c "/home/script_dir/build-tools-gcc/build-gcc -a x86_64_mingw -v 9 $USE_TAR && rm -rf /home/work_dir/*"
