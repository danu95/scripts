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


# === Configuration ===
INSTALL_DIR=/home/daniel/.config/kanata
# BIN_LINK= TBD # Brauche ich vermutlich nicht, weil ich es nicht im available PATH fürs system brauche
VERSION_ID="v1.10.1"
DOWNLOAD_URL="https://github.com/jtroo/kanata/releases/download/${VERSION_ID}/kanata-linux-binaries-${VERSION_ID}-x64.zip"
FILE_NAME="$(basename "$DOWNLOAD_URL")"

# === Log functions ===

log_event() {
    local message="$*"

    local timestamp
    timestamp="$(date -Is)"

    local user
    user="$(whoami)"

    local application
    application="$(basename "$0")"

    echo "timestamp=${timestamp}; user/system=${user}; application=${application}; message=${message}"
}

# === Check ob es bereits einen Kanata Ordner gibt und sonst einen erstlelen ===

if [[ ! -d "$INSTALL_DIR" ]]; then 
    mkdir -p "$INSTALL_DIR"
    log_event "created direcotry: $INSTALL_DIR"
else 
    log_event "directory already exists: $INSTALL_DIR"
fi

# === Download file ===

# Check if curl is available
if ! command -v curl &>/dev/null 2>&1; then
    log_event "curl not found, please install curl first"
    exit 1
fi
# Download Neovim archive if not already downloaded
if [[ ! -f "$INSTALL_DIR/$FILE_NAME" ]]; then
    log_event "downloading kanata zip into $INSTALL_DIR"
    curl -fL -o "$INSTALL_DIR/$FILE_NAME" "$DOWNLOAD_URL"

    # === Extract file ===
    log_event "unzip kanata zip file $FILE_NAME"
    unzip -o "$INSTALL_DIR/$FILE_NAME" -d "$INSTALL_DIR"

    log_event "change directory and make kanata executable"
    cd "$INSTALL_DIR"
    chmod +x "$INSTALL_DIR/kanata_linux_x64"
else 
    log_event "file $INSTALL_DIR already present"
    exit 1
# -L : Follow redirects (GitHub releases use redirects)
# -O : Save the file with its original filename

fi

# === Move kanata.kbd ins korrekte directory ===
log_event "Move kanata.kbd ins korrekte directory" 
cp ~/git/scripts/kanata.kbd ~/.config/kanata/










