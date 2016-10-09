#!/usr/bin/env bash
set -e
set -u
set -o pipefail

source "src/main/bash/scripting/color.sh"

usage() { echo "usage: (help | toc) <filename>"; }

[ $# -eq 2 ] || usage_error "expected 2 arguments, got $#"

case "$1" in
    help | toc) print_output="$1";;
    *) usage_error "Unrecognised command: $1";;
esac

[ -x "$2" ] || usage_error "not executable: $2"

help() {
    echo
    echo "### \`$1\`"
    echo
    "$2" --help | sed 's/^usage: \(.*\)/usage: `\1`/'
    echo
}

toc() {
    echo "- $("$2" --help | head -3 | tail -1 | sed -nE 's/`([^`]+)`/[`\1`](#\1)/p')"
}

"${print_output}" "$(basename "$2")" "$2"
