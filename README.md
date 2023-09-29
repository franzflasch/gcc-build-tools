# GCC crosstoolchain build script

This is a simple script to build gcc based (cross) toolchains for various platforms. It is much like crosstool-ng, just simpler.  

The buildscript is able to build toolchains and cross-toolchains for Linux hosts and targets Linux, Windows (mingw) as well as baremetal targets.

Specifically these target architectures are currently supported:

    - arm 
    - arm64 
    - avr8
    - cortex-m0 
    - cortex-m3 
    - cortex-m4 
    - riscv32 
    - riscv32-baremetal 
    - riscv64 
    - riscv64-baremetal
    - riscv64-uclibc 
    - x86 
    - x86_64 
    - x86_64_mingw 
    - x86_mingw 

Supported GCC versions:
- GCC-latest
- GCC-13
- GCC-12
- GCC-11
- GCC-10

Please be aware that some target/version combinations might not work.

## Prebuilt toolchains can be downloaded here (note: links are only valid 90 days after the last successful github ci runner)

https://nightly.link/franzflasch/gcc-build-tools/workflows/arm/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/arm64/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/avr8/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/cortex-m0/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/cortex-m3/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/cortex-m4/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/riscv32/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/riscv32-baremetal/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/riscv64/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/riscv64-baremetal/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/riscv64-uclibc/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/x86/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/x86_64/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/x86_64_mingw/main/toolchain_built_from_tar  
https://nightly.link/franzflasch/gcc-build-tools/workflows/x86_mingw/main/toolchain_built_from_tar  

> **_NOTE:_** Make sure to extract the prebuilt toolchains to ```/opt/local/``` otherwise there might be issues for certain builds.

## Prerequisites

To build a toolchain, you need to do the following:

A Linux distribution (the script has been tested on Ubuntu 22.04)  
Core developer packages
+ For Ubuntu 22.04:  
```bash
sudo apt install -y wget build-essential make gawk git subversion texinfo autoconf autopoint pkg-config gettext txt2man liblzma-dev libssl-dev libz-dev flex bison libexpat1-dev rsync file
```

In case you want to build a baremetal target you also need to install:
+ For picolibc:
```bash
sudo apt install -y python3-pip
sudo pip3 install meson ninja
```

### Install directory

> **_IMPORTANT:_**  Create the folder ```/opt/local/``` and ensure that you have write permissions otherwise the script wont work!!

## Using the script

Once you have set up your environment, you can use the script like this:

1. Clone the repository
```bash
git clone https://github.com/franzflasch/gcc-build-tools
```

2. Add the script to your path
```bash
cd gcc-build-tools
export PATH=$PWD:$PATH
```

3. Create a work directory for your build
```bash
mkdir ~/gcc-builds
cd ~/gcc-builds
```

4. Use it!
```bash
build-gcc -h
```

The printout will show you how to run the script.

Example commands:

```bash
# build a riscv64-uclibc toolchain, stripping binaries, verbose mode
build-gcc -a riscv64-uclibc -v 13 -s -V

# Build a toolchain for x86_64
./build-gcc -a x86_64 -v 13

# Build a toolchain for arm64
./build-gcc -a arm64 -v 13

# Build a toolchain for arm
./build-gcc -a arm -v 13

# Build a toolchain for riscv linux
./build-gcc -a riscv64 -v 13

# Build a toolchain for avr microcontrollers
./build-gcc -a avr8 -v 13 -t

# Build a toolchain for arm cortex m3/m4 microcontrollers
./build-gcc -a cortex-m3 -v 13 -t

# Build a toolchain for riscv baremetal (sifive hifive1)
./build-gcc -a riscv32-baremetal -v 13
```

### After compilation

The end result will be placed into ```/opt/local/``` e.g. ```/opt/local/cross-tool-riscv64-uclibc-gcc13/```.  

To use the toolchain just add ```/opt/local/cross-tool-riscv64-uclibc-gcc13/bin``` to your $PATH and thats it.


## Notes on using the toolchain

Building a fully static linked executable:
```bash
<target-triple>-gcc -o hello -static hello.c
```

With OpenMP:
```bash
<target-triple>-gcc -o omp_helloc -static -fopenmp omp_hello.c
```

For shared libraries ensure that you are building using the internal toolchain libs instead of ones already installed on the host linux - here for x86_64 openmp example:
```bash
x86_64-linux-gnu-gcc -o omp_helloc -Wl,--rpath=toolchain/lib64 -Wl,--rpath=toolchain/x86_64-linux-gnu/lib/ -Wl,--dynamic-linker=toolchain/x86_64-linux-gnu/lib/ld-linux-x86-64.so.2 -fopenmp omp_hello.c
```
For crosscompile targets it is probably necessary to install those libs into the target rootfs.

# For developers

Adding a new target should be rather easy:
- Add a new target file in ```configs/targets```. Look at the existing targets to get an idea how to add your own.
- There are default configs defined in ```configs/targets_config.sh``` that should be used as a base if possible.
- SRC URLs for the various open source packages (gcc, binutils etc.) are handled in ```configs/common.sh```.
- SRC VERSIONs are handled either in ```configs/git_source_config.sh``` and ```configs/tar_source_config.sh```. 
    - ```git_source_config.sh``` defines SRC URLs for git repositories.
    - ```tar_source_config.sh``` defines SRC URLs for tarballs.

## Pull requests/issues

Feel free to open an issue!

Pull requests are more than welcome as well!
