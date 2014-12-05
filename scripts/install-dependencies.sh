#!/usr/bin/env bash
set -euo pipefail

cabal update
cabal install shellcheck
