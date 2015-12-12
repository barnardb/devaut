# To include this in a file use something like the following:
#     scripting_dir="$(dirname "$BASH_SOURCE")"
#     source "${scripting_dir}/color.sh"

format() {
    printf %b "\e[$1m"
    if [ $# -gt 2 ]; then
        printf '%s\n' "${@:3}"
    else
        cat
    fi
    printf %b "\e[$2m"
}

bold() {
    format 1 22 "$@"
}

dim() {
    format 2 22 "$@"
}

italic() {
    format 3 23 "$@"
}

underline() {
    format 4 24 "$@"
}

negative() {
    format 7 27 "$@"
}

italic() {
    format 3 23 "$@"
}

function define_colors() {
    colors=(black red green yellow blue magenta cyan white)
    declare -i c=0
    while [ $c -lt "${#colors[@]}" ]; do
        eval "${colors[$c]}() { format '3$c' 39 \"\$@\"; }"
        eval "on_${colors[$c]}() { format '4$c' 49 \"\$@\"; }"
        eval "bright_${colors[$c]}() { format '9$c' 39 \"\$@\"; }"
        #eval "on_bright_${colors[$c]}() { format '10$c' 49 \"\$@\"; }"
        c+=1
    done
}
define_colors

italic() {
    format 3 23 "$@"
}


usage_error() {
    bright_red "Error: $1"
    usage
    echo
    printf '%s\n' "Use -? or --help for help" "${@:2}"
    exit 2
} >&2


warn() {
    yellow "$@"
}

fail() {
    bright_red "Error: $1"
    exit 1
} >&2

success() {
    green "$@"
}

status() {
    blue "$@"
}

prompt() {
    read -r -p "$(bright_blue "$@")"
}
