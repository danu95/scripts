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
# Fixed the typo here: changed ALACRITTYT_DIR to ALACRITTY_DIR
ALACRITTY_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/alacritty"

# === Create folders if not yet there ===
if [ ! -d "$ALACRITTY_DIR" ]; then
    log "create folders"
    mkdir -p "$ALACRITTY_DIR"
else
    log "folder is already created"
fi

# === Copy the alacritty.toml file into the correct place ===
log "copy the config file into the correct directory"
cp alacritty.toml "$ALACRITTY_DIR/alacritty.toml"


