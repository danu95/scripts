#!/usr/bin/env bash
# !!! shebang für bash immer auf die erste Zeile!

# Das Script ist an neovim_install.sh orientiert. 
# TODO! Verstehen wie neovim_install.sh funktioniert und es vereinfachen? nachbauen?
# Den Anweisungen für Linux unter "https://github.com/jtroo/kanata/releases" folgen. 

# Zwischendurch die Version checken und vielleicht auf eine höhre Upgraden? 

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

    echo "timestamp=${timestamp}; user/system=${user}; application=${application}; message=${message}"
}

# === Configuration ===
TMUX_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux"
TPM_DIR="$TMUX_DIR/plugins/tpm"

# === Create folders if not yet there ===
log "create folders"
mkdir -p "$TMUX_DIR/plugins"

# === Download tmux plugin manager with git ===
if [ -d "$TPM_DIR" ]; then
    log "plugin manager already installed"
else
    log "installing the tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# === Copy the tmux.conf file into the correct place ===
# btw. the tmux conf is inspired/copied from https://www.youtube.com/watch?v=DzNmUNvnB04 -> https://github.com/dreamsofcode-io/tmux/blob/main/tmux.conf
log "copy the config file into the correct directory"
cp tmux.conf "$TMUX_DIR/tmux.conf"






