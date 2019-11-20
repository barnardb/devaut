#!/usr/bin/env bash

set -e
set -u
set -o pipefail

help() {
    echo
    echo "### \`$1\`"
    echo
    "$2" --help | sed '1s/^usage: \(.*\)/usage: `\1`/'
    echo
}

toc() {
    echo "- [\`$1\`](#$1) $("$2" --help | sed -nE "3s/^\`$1\` //p")"
}

mapfile -t commands < <(find src/main/bash -type f -perm -u+x | sort)

for c in "${commands[@]}"; do
    "$1" "$(basename "$c")" "$c"
done
