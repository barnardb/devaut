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

# Notes on shellcheck exclusions:
#   - SC2016 is ignored because it complains about backticks in single-quotes,
#     which we use as in markdown, but shellcheck assumes we intended to be
#     command substitution and thus wants to see them in double-quotes.
#     (We would use the dollar-and-parentheses syntax for that: `$(…)`.)

find_scripts      -perm -u+x | xargs -0 shellcheck --external-sources --exclude=SC2016
find_scripts -not -perm -u+x | xargs -0 shellcheck --external-sources --exclude=SC2016 --shell=bash
