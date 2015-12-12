#!/usr/bin/env bash
set -e
set -u
set -o pipefail


find_scripts() {
    find \
        go \
        src/main/bash \
        scripts \
        -type f \
        \( -not -name '*.swp' \) \
        \( "$@" \) \
        -print0
}
find_scripts -perm +0111 | xargs -0 shellcheck --exclude=SC2016,SC1090
find_scripts -not -perm +0111 | xargs -0 shellcheck --exclude=SC2016,SC2148

rm -rf target
mkdir -p target

update_readme() {
    command_descriptions="$(find src/main/bash -type f -perm ++x -exec ./build/generate-command-markdown.sh "$1" {} ';')"
    cp README.md target/previous_README.md
    awk '/'"$2"'/ { print; while (getline < "/dev/stdin") print; print ""; getline; while (!/'"$3"'/) getline } { print }' \
        target/previous_README.md \
        <<<"${command_descriptions}" \
        >README.md
}

update_readme help "BEGIN AUTOGEN COMMAND DESCRIPTIONS" "END AUTOGEN COMMAND DESCRIPTIONS"
update_readme toc "#commands" "#dev-dependencies"
