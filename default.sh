#!/usr/bin/env bash
# !!! shebang für bash immer auf die erste Zeile!

# === ERROR HANDLING ===
set -euo pipefail
# -e : Exit immediately if any command exits with a non-zero status
# -u : Treat unset variables as an error and exit
# -o pipefail : If any command in a pipeline fails, the whole pipeline fails

# === Log functions ===
log() {
    local message="$*"

    local timestamp
    timestamp="$(date -Is)"

    local user
    user="$(whoami)"

    local application
    application="$(basename "$0")"

    echo "message=${message}; timestamp=${timestamp}; user/system=${user}; application=${application}"
}

# === Configuration ===
TEST_STR="Test"
TEST_INT=1

# === SCRIPT ===

