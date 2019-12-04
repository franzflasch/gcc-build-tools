#!/bin/bash

set -e

if [ $# -eq 0 ]; then
	echo "Please specify compiler prefix"
	echo "Example: ${0} x86_64-w64-mingw32"
	exit 1
fi

c_comp=${1}-gcc
cpp_comp=${1}-g++

mkdir -p build_out
${c_comp} hello_world.c -o build_out/hello_world_c.executable
${c_comp} hello_pthreads.c -static -lpthread -o build_out/hello_pthreads_c.executable
${cpp_comp} hello_world.cpp -o build_out/hello_world_cpp.executable
${cpp_comp} hello_mutex.cpp -static -pthread -Wl,--whole-archive -lpthread -Wl,--no-whole-archive -o build_out/hello_mutex_cpp.executable

