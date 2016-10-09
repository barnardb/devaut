#!/usr/bin/env bash

awk_script="$(cat <<'END'

    /^<!-- !START RAW! .+ -->$/ {
        print
        print ""
        sub(/^<!-- !.*?! /, "")
        sub(/ -->$/, "")
        command=$0
        while (!/^<!-- !END RAW! -->$/) getline
        system(command)
        print ""
    }
    
    // { print }

END
)"

awk "${awk_script}" "$1"
