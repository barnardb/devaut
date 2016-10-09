#!/usr/bin/env bash

set -e
set -u
set -o pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

./build/check-scripts.sh go build src/main/bash

mkdir -p target
./build/expand-markdown.sh README.md > target/README.md

changes="$(diff README.md target/README.md)" || {
    echo "There are changes for README.md in target/README.md:"
    echo
    echo "${changes}"
    echo
    echo "Run the following to copy these changes into README.md: "
    echo
    echo "    cp target/README.md README.md"
    echo
    exit 1
}
