# GCC toolchain build script

This is a script to build GCC toolchains targeting the following architectures
- linux:  
    arm  
    arm64  
    x86  
    x86_64  
    
- baremetal  
    arm  
    avr  
    risc-v  

## Using the script

To build a toolchain, you will need to the
following:

+ A Linux distribution (the script has been tested on Debian Stretch)
+ Core developer packages
    + For Debian 9: ```sudo apt-get install -y build-essential make gawk git subversion texinfo autoconf autopoint pkg-config gettext txt2man liblzma-dev libssl-dev libz-dev flex bison```

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

# Build a toolchain for avr microcontrollers
./build-gcc -a avr8 -v 8 -t

# Build a toolchain for arm cortex m3/m4 microcontrollers
./build-gcc -a cm4f -v 8 -t
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


## Credits/thanks

+ [nathanchance](https://github.com/nathanchance): For great modifications!
+ [frap129](https://github.com/frap129): For some modifications to update the script/components
+ [MSF-Jarvis](https://github.com/MSF-Jarvis): For testing the arm option
