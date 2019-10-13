#!/usr/bin/env bash
# shellcheck disable=SC2034

find . -type f \( -name "*.sh" -o -name "build-gcc" \) -exec shellcheck {} \;
