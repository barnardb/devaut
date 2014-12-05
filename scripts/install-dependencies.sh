#!/bin/sh
set -euo pipefail

cabal update
cabal install shellcheck
