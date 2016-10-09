# To include this in a file use something like the following:
#     scripting_dir="$(dirname "${BASH_SOURCE[0]}")"
#     source "${scripting_dir}/color.sh"

function style_text {
    case $# in
        [0-1]) echo "usage: style_text <start-escape-code> <end-escape-code> [lines...]" >&2; return 2;;
        2) lines=("$(cat)");;
        *) lines=("${@:3}");;
    esac
    printf '%b%s%b\n' "\e[$1m" "${lines[@]}" "\e[$2m"
}

function bold      { style_text 1 22 "$@"; }
function dim       { style_text 2 22 "$@"; }
function italic    { style_text 3 23 "$@"; }
function underline { style_text 4 24 "$@"; }
function negative  { style_text 7 27 "$@"; }

colors=(black red green yellow blue magenta cyan white)
for c in "${!colors[@]}"; do
    eval "function ${colors[$c]}           { style_text 3$c 39 \"\$@\"; }"
    eval "function on_${colors[$c]}        { style_text 4$c 49 \"\$@\"; }"
    eval "function bright_${colors[$c]}    { style_text 9$c 39 \"\$@\"; }"
    eval "function on_bright_${colors[$c]} { style_text 10$c 49 \"\$@\"; }"
done

function status  { blue "$@"; }
function success { green "$@"; }
function warn    { yellow "$@"; }

function prompt {
    read -r -p "$(bright_blue "$@")"
}

function fail {
    bright_red "Error: $1"
    exit 1
} >&2

function usage_error {
    bright_red "Error: $1"
    usage
    echo
    printf '%s\n' "Use -? or --help for help" "${@:2}"
    exit 2
} >&2
