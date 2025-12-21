
#!/usr/bin/env bash

# Das Script ist an neovim_install.sh orientiert. 
# TODO! Verstehen wie neovim_install.sh funktioniert und es vereinfachen? nachbauen?
# Den Anweisungen für Linux unter "https://github.com/jtroo/kanata/releases" folgen. 

# Zwischendurch die Version checken und vielleicht auf eine höhre Upgraden? 

# === ERROR HANDLING ===
set -euo pipefail

# === Configuration ===
INSTALL_DIR= 
# kann ich hier nicht einfach das downlodas directory nehmen?
BIN_LINK=
# muss kurz nachschauen, wo man es hinkopierten müsste
# evt hier? INSTALL_PATH="/usr/local/bin/kanata"
VERSION_ID="v1.10.0"
DOWNLOAD_URL="https://github.com/jtroo/kanata/releases/download/${VERSION_ID}/linux-binaries-x64-v1.10.0.zip"

# Oben einfügen
TMP_DIR="/tmp/kanata-install"
# brauche ich ein tmp_dir?

# === FUNCTIONS ===
# brauche ich diese functions?
# scheint noch nice zu sein mit dem log oder error, einfach zum weiteren handling. 
# nachschauen, wie man korrekte logs und errors schreibt?
log() {
    echo "[INFO] $*"
}

error() {
    echo "[ERROR] $*" >&2
    exit 1
}

# Check if curl is available
# hier anstelle von installieren einfach stoppen?
if ! command -v curl &>/dev/null; then
    log "curl not found. Installing..."
    sudo apt update -y && sudo apt install -y curl
fi


# Download Neovim archive if not already downloaded or outdated
log "Downloading latest Neovim build..."
curl -LO "$DOWNLOAD_URL"







