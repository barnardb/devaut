#!/usr/bin/env bash

set -e
set -u
set -o pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

rm -rf target
mkdir -p target/bin

./build/check-scripts.sh go build src/main/bash

commands=($(find src/main/bash -type f -perm -u+x | sort))
awk_script="$(cat <<'END'
    $0 == "source \"$(dirname \"${BASH_SOURCE[0]}\")/scripting/color.sh\"" {
        while ((getline < "src/main/bash/scripting/color.sh") > 0) print
        getline
    }
    // { print }
END
)"
for c in "${commands[@]}"; do
    output="target/bin/$(basename "$c")"
    awk "${awk_script}" "$c" > "${output}"
    chmod +x "${output}"
done

./target/bin/expand-markdown --verify-unchanged README.md target/README.md
