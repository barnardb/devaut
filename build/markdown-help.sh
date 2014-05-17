#/usr/env/bin bash
set -e
set -u
set -o pipefail

fail() { echo "$1" >&2; exit 1; }
[ $# -eq 1 ] || fail "usage: <filename>"
[ -x "$1" ] || fail "not executable: $1"

echo
echo "### \`$(basename "$1")\`"
echo
"$1" --help | sed 's/^usage: \(.*\)/usage: `\1`/'
echo
