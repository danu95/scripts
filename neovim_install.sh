#!/usr/bin/env bash
set -euo pipefail

# === CONFIGURATION ===
INSTALL_DIR="/opt/nvim-linux-x86_64"
BIN_LINK="/usr/local/bin/nvim"
ARCHIVE_NAME="nvim-linux-x86_64.tar.gz"
DOWNLOAD_URL="https://github.com/neovim/neovim/releases/latest/download/${ARCHIVE_NAME}"

# === FUNCTIONS ===
log() {
    echo "[INFO] $*"
}

error() {
    echo "[ERROR] $*" >&2
    exit 1
}

# Check if curl is available
if ! command -v curl &>/dev/null; then
    log "curl not found. Installing..."
    sudo apt update -y && sudo apt install -y curl
fi

# Download Neovim archive if not already downloaded or outdated
log "Downloading latest Neovim build..."
curl -LO "$DOWNLOAD_URL"

# Extract version info from the downloaded binary
TEMP_DIR=$(mktemp -d)
tar -xzf "$ARCHIVE_NAME" -C "$TEMP_DIR"

NEW_NVIM_VERSION=$("$TEMP_DIR"/nvim-linux-x86_64/bin/nvim --version | head -n1 | awk '{print $2}')

CURRENT_NVIM_VERSION=""
if [[ -x "$BIN_LINK" ]]; then
    CURRENT_NVIM_VERSION=$("$BIN_LINK" --version | head -n1 | awk '{print $2}')
fi

if [[ "$NEW_NVIM_VERSION" == "$CURRENT_NVIM_VERSION" ]]; then
    log "Neovim $NEW_NVIM_VERSION is already installed. No changes made."
    rm -rf "$TEMP_DIR" "$ARCHIVE_NAME"
    exit 0
fi

log "Installing Neovim $NEW_NVIM_VERSION..."

# Clean old install
sudo rm -rf "$INSTALL_DIR"

# Create install directory
sudo mkdir -p "$INSTALL_DIR"
sudo chmod a+rX "$INSTALL_DIR"

# Extract to /opt
sudo tar -C /opt -xzf "$ARCHIVE_NAME"

# Create/Update symlink
sudo ln -sf "$INSTALL_DIR/bin/nvim" "$BIN_LINK"

# Cleanup
rm -rf "$TEMP_DIR" "$ARCHIVE_NAME"

# Confirm success
log "Neovim $NEW_NVIM_VERSION installed successfully."
"$BIN_LINK" --version | head -n 1




