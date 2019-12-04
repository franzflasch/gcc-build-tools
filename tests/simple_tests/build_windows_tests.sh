#!/bin/bash

set -e

if [ $# -eq 0 ]; then
        echo "Please specify compiler prefix - e.g. x86_64-linux-gnu"
	echo "Example: ${0} x86_64-w64-mingw32"
        exit 1
fi

c_comp=${1}-gcc
cpp_comp=${1}-g++

mkdir -p build_out
${c_comp} -mwindows hello_windows.c -o build_out/hello_windows_c.executable
