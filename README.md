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
- GCC-16 (latest)
- GCC-15
- GCC-14
- GCC-13

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

> **_NOTE:_** Make sure to extract the prebuilt toolchains to `/opt/local/` otherwise there might be issues for certain builds.

## Prerequisites

To build a toolchain, you need the following:

A Linux distribution (tested on Ubuntu 26.04)

```bash
sudo apt install -y wget build-essential make gawk git subversion texinfo autoconf autopoint pkg-config gettext txt2man liblzma-dev libssl-dev libz-dev flex bison python3 python3-dev meson rsync file
```

### Install directory

> **_IMPORTANT:_** Create the folder `/opt/local/` and ensure that you have write permissions, otherwise the script will not work.

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
# Build a riscv64-uclibc toolchain, stripping binaries, verbose mode
build-gcc -a riscv64-uclibc -v 16 -s -V

# Build a toolchain for x86_64
build-gcc -a x86_64 -v 16

# Build a toolchain for arm64
build-gcc -a arm64 -v 16

# Build a toolchain for arm
build-gcc -a arm -v 16

# Build a toolchain for riscv linux
build-gcc -a riscv64 -v 16

# Build a toolchain for avr microcontrollers
build-gcc -a avr8 -v 16 -t

# Build a toolchain for arm cortex m3/m4 microcontrollers
build-gcc -a cortex-m3 -v 16 -t

# Build a toolchain for riscv baremetal (sifive hifive1)
build-gcc -a riscv32-baremetal -v 16
```

### After compilation

The end result will be placed into `/opt/local/`, e.g. `/opt/local/cross-tool-riscv64-uclibc-gcc16/`.

To use the toolchain just add `/opt/local/cross-tool-riscv64-uclibc-gcc16/bin` to your `$PATH` and that's it.

## Notes on using the toolchain

Building a fully static linked executable:
```bash
<target-triple>-gcc -o hello -static hello.c
```

With OpenMP:
```bash
<target-triple>-gcc -o omp_helloc -static -fopenmp omp_hello.c
```

For shared libraries ensure that you are building using the internal toolchain libs instead of ones already installed on the host Linux — here for an x86_64 OpenMP example:
```bash
x86_64-linux-gnu-gcc -o omp_helloc -Wl,--rpath=toolchain/lib64 -Wl,--rpath=toolchain/x86_64-linux-gnu/lib/ -Wl,--dynamic-linker=toolchain/x86_64-linux-gnu/lib/ld-linux-x86-64.so.2 -fopenmp omp_hello.c
```

For cross-compile targets it is probably necessary to install those libs into the target rootfs.

# For developers

Adding a new target should be rather easy:
- Add a new target file in `configs/targets`. Look at the existing targets to get an idea how to add your own.
- There are default configs defined in `configs/targets_config.sh` that should be used as a base if possible.
- SRC URLs for the various open source packages (gcc, binutils etc.) are handled in `configs/common.sh`.
- SRC versions are handled in `configs/git_source_config.sh` and `configs/tar_source_config.sh`.
  - `git_source_config.sh` defines versions for git repository checkouts.
  - `tar_source_config.sh` defines versions for tarball downloads.

## Pull requests/issues

Feel free to open an issue!

Pull requests are more than welcome as well!
