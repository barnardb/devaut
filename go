#!/usr/bin/env bash
set -e
set -u
set -o pipefail

shellcheck go

git ls-files src/main/bash -z | xargs -0 shellcheck

rm -rf target
mkdir -p target

command_descriptions="$(git ls-files src/main/bash/ -z | xargs -0 -n 1 ./build/markdown-help.sh)"
cp README.md target/previous_README.md
awk '/BEGIN/ { print; while (getline < "/dev/stdin") print; print ""; getline; while (!/END/) getline } { print }' \
    target/previous_README.md \
    <<<"${command_descriptions}" \
    >README.md
