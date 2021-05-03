# GCC crosstoolchain build script

I wanted to create my own toolchain build script as I am not happy with the existing ones. Either they are too complicated to make changes on my own or they are simply not implemeted properly.  
The main goals were to keep things as simple as possible, it should always be easy to know what the buildsystem actually does and it should be possible to do changes on my own. It has a lot more features than its original. I removed superflous features and added a lot of new ones instead.
The buildscript is able to build toolchains or crosstoolchains for Linux hosts and targets Linux, Windows (mingw) and also a lot of baremetal targets.

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
    - x86 
    - x86_64 
    - x86_64_mingw 
    - x86_mingw 

This script was originally a fork of https://github.com/USBhost/build-tools-gcc but it actually has not much left in common with its origin. I've the feeling
that as long as this project is "hidden" as a fork it does not get much attention, so I made a new independent project out of it.

## Prebuilt toolchains can be downloaded here (note: links are only valid 90 days after the last successful github ci runner)

https://nightly.link/franzflasch/gcc-build-tools/workflows/arm/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/arm64/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/avr8/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/cortex-m0/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/cortex-m3/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/cortex-m4/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/riscv32/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/riscv32-baremetal/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/riscv64/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/riscv64-baremetal/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/x86/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/x86_64/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/x86_64_mingw/master/toolchain_built_from_tar
https://nightly.link/franzflasch/gcc-build-tools/workflows/x86_mingw/master/toolchain_built_from_tar

## Using the script

To build a toolchain, you will need to do the following:

A Linux distribution (the script has been tested on Debian Stretch/Buster)
Core developer packages
+ For Debian 9 or 10:  
```bash
sudo apt install -y wget build-essential make gawk git subversion texinfo autoconf autopoint pkg-config gettext txt2man liblzma-dev libssl-dev libz-dev flex bison libexpat1-dev rsync
```

For picolibc
```bash
sudo apt install -y python3-pip
sudo pip3 install meson ninja
```

Once you have set up your environment, run the following:

```bash
git clone https://github.com/franzflasch/gcc-build-tools
cd gcc-build-tools
./build-gcc -h
```

The printout will show you how to run the script.

Example commands:

```bash
# Build a toolchain for x86_64
./build-gcc -a x86_64 -v 7

# Build a toolchain for arm64
./build-gcc -a arm64 -v 7

# Build a toolchain for arm
./build-gcc -a arm -v 8

# Build a toolchain for riscv linux
./build-gcc -a riscv64 -v 8

# Build a toolchain for avr microcontrollers
./build-gcc -a avr8 -v 8 -t

# Build a toolchain for arm cortex m3/m4 microcontrollers
./build-gcc -a cortex-m3 -v 8 -t

# Build a toolchain for riscv baremetal (sifive hifive1)
./build-gcc -a riscv32-baremetal -v 8
```

## After compilation

Once it is done building, you will have a folder with the compiled toolchain as well as either a tar.xz or tar.gz file (depending on if you passed -p or not).

If the toolchains are compressed, move them into your directory of choice and run the following commands:

For xz compression:

```bash
tar -xvf <toolchain_name>.tar.xz --strip-components=1
```

For gz compression:

```bash
tar -xvzf <toolchain_name>.tar.gz --strip-components=1
```

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

## Pull requests/issues

If you have any issues with this script, feel free to open an issue!

Pull requests are more than welcome as well. However, there is a particular coding style that should be followed:

+ All variables are uppercased and use curly braces: ```${VARIABLE}``` instead of ```$variable```
+ Four spaces for indents
+ Double brackets and single equal sign for string comparisons in if blocks: ```if [[ ${VARIABLE} = "yes" ]]; then```

Additionally, please be sure to run your change through shellcheck.net (either copy and paste the script there or download the binary and run `shellcheck build`).
