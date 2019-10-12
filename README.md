# GCC crosstoolchain build script

This is a script to build GCC toolchains targeting the following architectures
    - arm64 (linux)
    - arm   (linux)
    - avr8  (baremetal)
    - cortex-m0 (baremetal)
    - cortex-m3 (baremetal)
    - riscv32-baremetal (baremetal)
    - riscv64 (linux)
    - x86_64 (linux)
    - x86 (linux)


## Using the script

To build a toolchain, you will need to the
following:

+ A Linux distribution (the script has been tested on Debian Stretch)
+ Core developer packages
    + For Debian 9 or 10:  
    ```sudo apt install -y wget build-essential make gawk git subversion texinfo autoconf autopoint pkg-config gettext txt2man liblzma-dev libssl-dev libz-dev flex bison```

Once you have set up your environment, run the following:

```bash
git clone https://github.com/franzflasch/build-tools-gcc
cd build-tools-gcc
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

## Pull requests/issues

If you have any issues with this script, feel free to open an issue!

Pull requests are more than welcome as well. However, there is a particular coding style that should be followed:

+ All variables are uppercased and use curly braces: ```${VARIABLE}``` instead of ```$variable```
+ Four spaces for indents
+ Double brackets and single equal sign for string comparisons in if blocks: ```if [[ ${VARIABLE} = "yes" ]]; then```

Additionally, please be sure to run your change through shellcheck.net (either copy and paste the script there or download the binary and run `shellcheck build`).
