#!/usr/bin/env bash

set -e
set -u
set -o pipefail

hash shellcheck 2>/dev/null || {
    cat <<'END'
Error: can't find shellcheck

Shellcheck is a linting tool for shell scripts that is implemented in Haskell.
It isn't needed to use DevAut commands, but is used by this build script to look for issues.
You can use your package manager to install it (e.g. `brew install shellcheck`),
or you can use Cabal (a packaging and build tool for Haskell):

    cabal update
    cabal install shellcheck

END
} >&2

files_and_directories=("$@")

find_scripts() {
    find \
        "${files_and_directories[@]}" \
        -type f \
        \( -not -name '*.swp' \) \
        \( "$@" \) \
        -print0
}

find_scripts      -perm -u+x | xargs -0 shellcheck --external-sources --exclude=SC2016,SC1090
find_scripts -not -perm -u+x | xargs -0 shellcheck --external-sources --shell=bash --exclude=SC2016
