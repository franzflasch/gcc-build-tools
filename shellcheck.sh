#!/usr/bin/env bash

find . -type f \( -name "*.sh" -o -name "build-gcc" \) -exec shellcheck {} \;
