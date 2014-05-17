function define_format {
    eval "$(printf "function $1 { printf '%b%%s%b\\\\n' \"\$@\"; }" "$2" '\\E[0m')"
}
define_format black '\\E[30m'
define_format red '\\E[31m'
define_format green '\\E[32m'
define_format yellow '\\E[33m'
define_format blue '\\E[34m'
define_format magenta '\\E[35m'
define_format cyan '\\E[36m'
define_format white '\\E[37m'

function fail { red "$@" >&2; exit 1; }
