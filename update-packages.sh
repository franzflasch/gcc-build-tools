#!/usr/bin/env bash
# update-packages.sh
# Checks upstream sources for newer package versions and updates
# configs/tar_source_config.sh and configs/git_source_config.sh.
#
# Usage:
#   ./update-packages.sh            # detect + patch config files
#   ./update-packages.sh --dry-run  # detect + report only, no file changes

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TAR_CONFIG="${TAR_CONFIG:-${SCRIPT_DIR}/configs/tar_source_config.sh}"
GIT_CONFIG="${GIT_CONFIG:-${SCRIPT_DIR}/configs/git_source_config.sh}"

DRY_RUN=false
GCC_MAJOR_OVERRIDE=""

# ─── Colours ─────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ─── Argument parsing ─────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run) DRY_RUN=true ;;
        --gcc-major=*) GCC_MAJOR_OVERRIDE="${1#--gcc-major=}" ;;
        --gcc-major)
            [[ -z "${2:-}" ]] && { echo "Error: --gcc-major requires a value" >&2; exit 1; }
            GCC_MAJOR_OVERRIDE="$2"; shift ;;
        -h|--help)
            echo "Usage: $0 [--dry-run] [--gcc-major N]"
            echo ""
            echo "  --dry-run       Report available updates but do not modify any files."
            echo "  --gcc-major N   Override the GCC major version to target (default: auto-detected)."
            exit 0
            ;;
        *)
            echo "Unknown argument: $1" >&2
            exit 1
            ;;
    esac
    shift
done

# ─── Package table ────────────────────────────────────────────────────────────
# Format: "LABEL:CONFIG_VAR:FETCH_FUNC:GIT_TRANSFORM"
#
#   LABEL         — display name used in the report
#   CONFIG_VAR    — variable name as it appears in the config files
#   FETCH_FUNC    — function that returns the full ready-to-write tar value
#   GIT_TRANSFORM — function to derive the git value from the tar value,
#                   or "none" if the value is identical in both configs
#
# GCC is handled separately (needs GCC_MAJOR param + GCC_BRANCH special case).
PACKAGES=(
    "Binutils:BINUTILS:fetch_latest_binutils:binutils_tar_to_git"
    "GDB:GDB:fetch_latest_gdb:gdb_tar_to_git"
    "Linux:LINUX:fetch_latest_linux_lts:linux_tar_to_git"
    "glibc:GLIBC:fetch_latest_glibc:glibc_tar_to_git"
    "newlib:NEWLIB:fetch_latest_newlib:newlib_tar_to_git"
    "picolibc:PICOLIBC:fetch_latest_picolibc:skip"
    "uclibc-ng:UCLIBC_NG:fetch_latest_uclibc_ng:uclibc_tar_to_git"
    "avr-libc:AVRLIBC:fetch_latest_avrlibc:avrlibc_tar_to_git"
    "MinGW:MINGW:fetch_latest_mingw:none"
    "elf2flt:ELF2FLT:fetch_latest_elf2flt:none"
    "MPFR:MPFR:fetch_latest_mpfr:none"
    "GMP:GMP:fetch_latest_gmp:none"
    "MPC:MPC:fetch_latest_mpc:none"
    "ISL:ISL:fetch_latest_isl:none"
)

# Parallel arrays populated by fetch_all_packages() — shared across functions
declare -a PKG_LABELS=()
declare -a PKG_VARS=()
declare -a PKG_CURRENT=()
declare -a PKG_LATEST=()
declare -a PKG_GIT_TRANSFORM=()

# ─── Helpers ──────────────────────────────────────────────────────────────────

fetch_url() {
    curl -fsSL --max-time 20 "$1"
}

sort_versions() {
    sort -t. -k1,1n -k2,2n -k3,3n -k4,4n
}

section() {
    echo ""
    echo -e "${BOLD}${CYAN}══ $1 ══${RESET}"
}

# ─── Config readers ───────────────────────────────────────────────────────────

read_var() {
    local var="$1" func="$2" file="$3"
    awk "/^function ${func}/,/^}/" "$file" \
        | grep -oP "(?<=${var}=\")[^\"]+" | head -1
}

read_tar_var() {
    local var="$1" func="$2"
    read_var "$var" "$func" "$TAR_CONFIG"
}

detect_current_gcc_major() {
    grep -oP '(?<=setup_variables_tar_)\d+' "$TAR_CONFIG" \
        | sort -n | tail -1
}

# ─── Upstream fetchers ────────────────────────────────────────────────────────

fetch_latest_gnu_ftp() {
    local url="$1" prefix="$2"
    fetch_url "$url" \
        | grep -oP "(?<=${prefix}-)[0-9][0-9.]*(?=\.tar)" \
        | sort_versions | tail -1
}

# Returns e.g. "gcc-15.2.0"
fetch_latest_gcc() {
    local major="$1"
    local ver
    ver="$(fetch_url "https://ftp.gnu.org/gnu/gcc/" \
        | grep -oP "(?<=gcc-${major}\.)[0-9]+\.[0-9]+" \
        | awk -v m="$major" '{print m"."$0}' \
        | sort_versions | tail -1)"
    echo "gcc-${ver}"
}

fetch_latest_gcc_major() {
    fetch_url "https://ftp.gnu.org/gnu/gcc/" \
        | grep -oP '(?<=gcc-)\d+(?=\.\d+\.\d+/)' \
        | sort -n | tail -1
}

# Returns e.g. "2.46.0"
fetch_latest_binutils() {
    fetch_latest_gnu_ftp "https://ftp.gnu.org/gnu/binutils/" "binutils"
}

# Returns e.g. "gdb-17.1"
fetch_latest_gdb() {
    local ver
    ver="$(fetch_latest_gnu_ftp "https://ftp.gnu.org/gnu/gdb/" "gdb")"
    echo "gdb-${ver}"
}

# Returns e.g. "6.18.26"
fetch_latest_linux_lts() {
    fetch_url "https://www.kernel.org/releases.json" \
        | python3 -c "
import json, sys
data = json.load(sys.stdin)
lts = [r['version'] for r in data['releases'] if r['moniker'] == 'longterm' and not r['iseol']]
lts.sort(key=lambda v: [int(x) for x in v.split('.')])
print(lts[-1])
"
}

# Returns e.g. "glibc-2.43"
fetch_latest_glibc() {
    local ver
    ver="$(fetch_latest_gnu_ftp "https://ftp.gnu.org/gnu/glibc/" "glibc")"
    echo "glibc-${ver}"
}

# Returns e.g. "newlib-4.6.0.20260123"
fetch_latest_newlib() {
    local ver
    ver="$(fetch_url "https://sourceware.org/pub/newlib/" \
        | grep -oP '(?<=newlib-)[0-9][0-9.]*(?=\.tar)' \
        | sort_versions | tail -1)"
    echo "newlib-${ver}"
}

# Returns e.g. "1.8.11"
fetch_latest_picolibc() {
    git ls-remote --tags "https://github.com/keith-packard/picolibc.git" 2>/dev/null \
        | grep -oP '(?<=refs/tags/)[0-9][0-9.]+$' \
        | sort_versions | tail -1
}

# Returns e.g. "1.0.57"
fetch_latest_uclibc_ng() {
    fetch_url "https://downloads.uclibc-ng.org/releases/" \
        | grep -oP '(?<=href=")\d[\d.]+(?=/)' \
        | sort_versions | tail -1
}

# Returns e.g. "avr-libc-2_3_1"
fetch_latest_avrlibc() {
    git ls-remote --tags "https://github.com/avrdudes/avr-libc.git" 2>/dev/null \
        | grep -oP '(?<=refs/tags/)avr-libc-\d+_\d+_\d+(?=-release)' \
        | sort | tail -1
}

# Returns e.g. "v14.0.0"
fetch_latest_mingw() {
    git ls-remote --tags "https://github.com/mingw-w64/mingw-w64.git" 2>/dev/null \
        | grep -oP '(?<=refs/tags/)v\d+\.\d+\.\d+$' \
        | sed 's/^v//' | sort_versions | tail -1 \
        | sed 's/^/v/'
}

# Returns e.g. "v2024.05"
fetch_latest_elf2flt() {
    git ls-remote --tags "https://github.com/uclinux-dev/elf2flt.git" 2>/dev/null \
        | grep -oP '(?<=refs/tags/)v[0-9]{4}\.[0-9]+' \
        | sort -V | tail -1
}

# Returns e.g. "mpfr-4.2.2"
fetch_latest_mpfr() {
    local ver
    ver="$(fetch_latest_gnu_ftp "https://ftp.gnu.org/gnu/mpfr/" "mpfr")"
    echo "mpfr-${ver}"
}

# Returns e.g. "gmp-6.3.0"
fetch_latest_gmp() {
    local ver
    ver="$(fetch_latest_gnu_ftp "https://ftp.gnu.org/gnu/gmp/" "gmp")"
    echo "gmp-${ver}"
}

# Returns e.g. "mpc-1.4.1"
fetch_latest_mpc() {
    local ver
    ver="$(fetch_latest_gnu_ftp "https://ftp.gnu.org/gnu/mpc/" "mpc")"
    echo "mpc-${ver}"
}

# Returns e.g. "isl-0.27"
fetch_latest_isl() {
    local ver
    ver="$(fetch_url "https://libisl.sourceforge.io/" \
        | grep -oP '(?<=isl-)[0-9][0-9.]*(?=\.tar)' \
        | sort_versions | tail -1)"
    echo "isl-${ver}"
}

# ─── Version format translators (tar → git) ───────────────────────────────────

# "6.18.26"           → "v6.18.26"
linux_tar_to_git()   { echo "v$1"; }

# "2.46.0"            → "binutils-2_46-branch"
binutils_tar_to_git() {
    local major_minor
    major_minor="$(echo "$1" | cut -d. -f1,2)"
    echo "binutils-${major_minor//./_}-branch"
}

# "gdb-17.1"          → "gdb-17.1-release"
gdb_tar_to_git()     { echo "$1-release"; }

# "gcc-15.2.0"        → "gcc-15"  (git var)
gcc_tar_to_git_var() {
    local major
    major="$(echo "$1" | grep -oP '(?<=gcc-)\d+')"
    echo "gcc-${major}"
}

# "gcc-15.2.0"        → "releases/gcc-15"  (git branch)
gcc_tar_to_git_branch() { echo "releases/$(gcc_tar_to_git_var "$1")"; }

# "glibc-2.43"        → "glibc-2.43"  (same in both)
glibc_tar_to_git()   { echo "$1"; }

# "1.0.57"            → "v1.0.57"
uclibc_tar_to_git()  { echo "v$1"; }

# "avr-libc-2_3_1"   → "avr-libc-2_3_1-release"
avrlibc_tar_to_git() { echo "$1-release"; }

# "newlib-4.6.0.20260123" → "newlib-4.6.0"
newlib_tar_to_git()  { echo "$1" | grep -oP 'newlib-\d+\.\d+\.\d+'; }

# ─── Patch helper ─────────────────────────────────────────────────────────────

patch_var_in_func() {
    local file="$1" fname="$2" var="$3" new_val="$4"
    local tmpfile
    tmpfile="$(mktemp)"

    awk -v fname="$fname" -v var="$var" -v val="$new_val" '
        /^function / { in_func = ($0 ~ "^function " fname) }
        in_func && $0 ~ "^    " var "=" {
            sub(/"[^"]*"/, "\"" val "\"")
        }
        { print }
    ' "$file" > "$tmpfile"

    mv "$tmpfile" "$file"
}

# ─── Reporting ────────────────────────────────────────────────────────────────

declare -a REPORT_LABELS=()
declare -a REPORT_CURRENT=()
declare -a REPORT_LATEST=()
declare -a REPORT_STATUS=()

add_report() {
    local label="$1" current="$2" latest="$3"
    REPORT_LABELS+=("$label")
    REPORT_CURRENT+=("$current")
    REPORT_LATEST+=("$latest")
    if [[ -z "$latest" ]]; then
        REPORT_STATUS+=("unknown")
    elif [[ "$current" == "$latest" ]]; then
        REPORT_STATUS+=("up-to-date")
    else
        REPORT_STATUS+=("update")
    fi
}

print_report() {
    local w_name=10 w_cur=30 w_lat=30
    local header_fmt="%-${w_name}s  %-${w_cur}s  %-${w_lat}s  %s\n"
    local sep
    sep="$(printf '%0.s─' {1..85})"

    echo ""
    echo -e "${BOLD}Package version report${RESET}"
    echo "$sep"
    printf "$header_fmt" "PACKAGE" "CURRENT" "LATEST" "STATUS"
    echo "$sep"

    for i in "${!REPORT_LABELS[@]}"; do
        local colour
        case "${REPORT_STATUS[$i]}" in
            up-to-date) colour="$GREEN"  ;;
            update)     colour="$YELLOW" ;;
            *)          colour="$RED"    ;;
        esac
        printf "%-${w_name}s  %-${w_cur}s  %-${w_lat}s  " \
            "${REPORT_LABELS[$i]}" "${REPORT_CURRENT[$i]}" "${REPORT_LATEST[$i]}"
        echo -e "${colour}${REPORT_STATUS[$i]}${RESET}"
    done

    echo "$sep"
}

# ─── Package fetching ─────────────────────────────────────────────────────────

fetch_all_packages() {
    # GCC — special: needs GCC_MAJOR as argument, also checks for new major
    echo -n "  GCC ${GCC_MAJOR}.x …"
    local gcc_latest
    if ! gcc_latest="$(fetch_latest_gcc "$GCC_MAJOR" 2>/dev/null)"; then
        echo " (skipped — fetch failed)"
        gcc_latest=""
    else
        echo " ${gcc_latest}"
    fi

    echo -n "  GCC major (next?) …"
    if ! LATEST_GCC_MAJOR="$(fetch_latest_gcc_major 2>/dev/null)"; then
        echo " (skipped — fetch failed)"
        LATEST_GCC_MAJOR="$GCC_MAJOR"
    else
        echo " ${LATEST_GCC_MAJOR}"
    fi

    PKG_LABELS+=("GCC")
    PKG_VARS+=("GCC")
    PKG_CURRENT+=("$(read_tar_var GCC "$TAR_FUNC")")
    PKG_LATEST+=("$gcc_latest")
    PKG_GIT_TRANSFORM+=("gcc_tar_to_git_var")

    # All other packages — driven by the PACKAGES table
    local entry label var fetch_fn git_transform current latest
    for entry in "${PACKAGES[@]}"; do
        IFS=: read -r label var fetch_fn git_transform <<< "$entry"

        current="$(read_tar_var "$var" "$TAR_FUNC")"
        echo -n "  ${label} …"
        if ! latest="$($fetch_fn 2>/dev/null)"; then
            echo " (skipped — fetch failed)"
            latest=""
        else
            echo " ${latest}"
        fi

        PKG_LABELS+=("$label")
        PKG_VARS+=("$var")
        PKG_CURRENT+=("$current")
        PKG_LATEST+=("$latest")
        PKG_GIT_TRANSFORM+=("$git_transform")
    done
}

# ─── Config updaters ──────────────────────────────────────────────────────────

function update_tar_config() {
    section "Patching ${TAR_CONFIG##*/}"

    for i in "${!PKG_VARS[@]}"; do
        local var="${PKG_VARS[$i]}"
        local current="${PKG_CURRENT[$i]}"
        local latest="${PKG_LATEST[$i]}"
        if [[ "$current" != "$latest" && -n "$latest" ]]; then
            patch_var_in_func "$TAR_CONFIG" "$TAR_FUNC" "$var" "$latest"
            echo "  ${var}: ${current} → ${latest}"
        fi
    done
}

function update_git_config() {
    section "Patching ${GIT_CONFIG##*/}"

    local gcc_latest="${PKG_LATEST[0]}"
    local gcc_current_git
    gcc_current_git="$(read_var GCC "$GIT_FUNC" "$GIT_CONFIG")"

    for i in "${!PKG_VARS[@]}"; do
        local var="${PKG_VARS[$i]}"
        local latest="${PKG_LATEST[$i]}"
        local transform="${PKG_GIT_TRANSFORM[$i]}"
        local current_git latest_git

        current_git="$(read_var "$var" "$GIT_FUNC" "$GIT_CONFIG")"

        if [[ "$transform" == "skip" ]]; then
            continue
        elif [[ "$transform" == "none" ]]; then
            latest_git="$latest"
        else
            latest_git="$($transform "$latest")"
        fi

        if [[ "$current_git" != "$latest_git" && -n "$latest_git" ]]; then
            patch_var_in_func "$GIT_CONFIG" "$GIT_FUNC" "$var" "$latest_git"
            echo "  ${var}: ${current_git} → ${latest_git}"
        fi
    done

    # GCC_BRANCH uses ${GCC} variable reference — only update if GCC major changed
    if [[ "$gcc_current_git" != "$(gcc_tar_to_git_var "$gcc_latest")" ]]; then
        local cur_branch new_branch
        cur_branch="$(read_var GCC_BRANCH "$GIT_FUNC" "$GIT_CONFIG")"
        new_branch="$(gcc_tar_to_git_branch "$gcc_latest")"
        patch_var_in_func "$GIT_CONFIG" "$GIT_FUNC" "GCC_BRANCH" "$new_branch"
        echo "  GCC_BRANCH: ${cur_branch} → ${new_branch}"
    fi

    # GLIBC_BRANCH uses ${GLIBC} variable reference — auto-follows GLIBC, no patch needed
}

# ─── Main ─────────────────────────────────────────────────────────────────────

main() {
    if [[ -n "$GCC_MAJOR_OVERRIDE" ]]; then
        GCC_MAJOR="$GCC_MAJOR_OVERRIDE"
    else
        GCC_MAJOR="$(detect_current_gcc_major)"
    fi
    TAR_FUNC="setup_variables_tar_${GCC_MAJOR}"
    GIT_FUNC="setup_variables_git_${GCC_MAJOR}"

    # Validate the target functions exist
    if ! grep -q "function ${TAR_FUNC}()" "$TAR_CONFIG"; then
        echo "Error: ${TAR_FUNC}() not found in ${TAR_CONFIG##*/}" >&2
        echo "       Available versions: $(grep -oP '(?<=setup_variables_tar_)\d+' "$TAR_CONFIG" | sort -rn | tr '\n' ' ')" >&2
        exit 1
    fi
    if ! grep -q "function ${GIT_FUNC}()" "$GIT_CONFIG"; then
        echo "Error: ${GIT_FUNC}() not found in ${GIT_CONFIG##*/}" >&2
        echo "       Available versions: $(grep -oP '(?<=setup_variables_git_)\d+' "$GIT_CONFIG" | sort -rn | tr '\n' ' ')" >&2
        exit 1
    fi

    echo -e "${BOLD}gcc-build-tools package updater${RESET}"
    echo "Active GCC major: ${BOLD}${GCC_MAJOR}${RESET}  (functions: ${TAR_FUNC} / ${GIT_FUNC})"
    if $DRY_RUN; then
        echo -e "${CYAN}[dry-run mode — no files will be modified]${RESET}"
    fi

    section "Fetching upstream versions (this may take a moment…)"
    fetch_all_packages

    if [[ "$LATEST_GCC_MAJOR" -gt "$GCC_MAJOR" ]]; then
        echo ""
        echo -e "${YELLOW}${BOLD}⚠  New GCC major version detected: GCC ${LATEST_GCC_MAJOR}${RESET}"
        echo -e "   The script does not update GCC major versions automatically."
        echo -e "   You need to manually add setup_variables_tar_${LATEST_GCC_MAJOR}() and"
        echo -e "   setup_variables_git_${LATEST_GCC_MAJOR}() to the config files."
    fi

    for i in "${!PKG_LABELS[@]}"; do
        add_report "${PKG_LABELS[$i]}" "${PKG_CURRENT[$i]}" "${PKG_LATEST[$i]}"
    done

    print_report

    local has_updates=false
    for s in "${REPORT_STATUS[@]}"; do
        [[ "$s" == "update" ]] && has_updates=true && break
    done

    if ! $has_updates; then
        echo ""
        echo -e "${GREEN}All packages are up-to-date.${RESET}"
        exit 0
    fi

    if $DRY_RUN; then
        echo ""
        echo -e "${CYAN}[dry-run] No files modified.${RESET}"
        exit 0
    fi

    update_tar_config
    update_git_config

    echo ""
    echo -e "${GREEN}Done. Both config files have been updated.${RESET}"
    echo "Review the changes with: git diff configs/"
}

main "$@"
