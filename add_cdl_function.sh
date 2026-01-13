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
# Correct zshrc detection (supports ZDOTDIR)
ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"

# === SCRIPT ===
# Das Script soll am Ende von .zshrc eine Funktion hinzufügen, die cd & ls vereint.

# === Check zshrc exists ===
if [[ ! -f "$ZSHRC" ]]; then
    log "check zsh config - no file here: $ZSHRC"
    exit 1
else
    log "zshrc found: $ZSHRC"
fi

# === Check if cdl() already exists ===
if grep -qE '^[[:space:]]*(function[[:space:]]+)?cdl[[:space:]]*\(\)?[[:space:]]*\{' "$ZSHRC"; then
    log "cdl() already exists"
    exit 0
fi

# === Append function ===
log "cdl() not found — adding function at the end of zshrc"

cat <<'EOF' >> "$ZSHRC"

# cd + list
cdl() {
  builtin cd "$@" || return
  ls -lhF --time-style=long-iso --color=auto --ignore=lost+found
}
EOF

log "done"



