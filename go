#!/usr/bin/env bash
set -e
set -u
set -o pipefail

shellcheck go

find src/main/bash -type f -exec shellcheck {} ';'

rm -rf target
mkdir -p target

command_descriptions="$(find src/main/bash -type f -perm ++x -exec ./build/markdown-help.sh {} ';')"
cp README.md target/previous_README.md
awk '/BEGIN/ { print; while (getline < "/dev/stdin") print; print ""; getline; while (!/END/) getline } { print }' \
    target/previous_README.md \
    <<<"${command_descriptions}" \
    >README.md
