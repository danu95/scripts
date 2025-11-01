
#!/usr/bin/env bash
set -euo pipefail

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
NVIM_CONFIG_DIR="$CONFIG_HOME/nvim"
SOURCE_DIR="/home/daniel/git/scripts/kickstart_modular"

log() { echo "[INFO] $*"; }
error() { echo "[ERROR] $*" >&2; exit 1; }

# Check source directory
if [ ! -d "$SOURCE_DIR" ]; then
    error "Source directory '$SOURCE_DIR' does not exist."
fi

# Create config dir if missing
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    log "Creating Neovim config directory at: $NVIM_CONFIG_DIR"
    mkdir -p "$NVIM_CONFIG_DIR"
else
    log "Neovim config directory already exists: $NVIM_CONFIG_DIR"
fi

cd "$NVIM_CONFIG_DIR" || error "Cannot change directory to $NVIM_CONFIG_DIR"

# Check for init.lua
if [ -f "init.lua" ]; then
    log "init.lua already exists — nothing to do. Exiting."
    exit 0
fi

# Copy files
log "Copying Neovim config files from $SOURCE_DIR ..."
cp -rT "$SOURCE_DIR" "$NVIM_CONFIG_DIR"

log "Neovim configuration successfully initialized."



