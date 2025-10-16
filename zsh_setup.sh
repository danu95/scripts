
#!/usr/bin/env bash
# ---------------------------------------------------------
# zsh_setup.sh – Set Zsh as default shell, install Oh My Zsh
# and custom plugins, with safe .zshrc update
# ---------------------------------------------------------

set -euo pipefail

# ---------------- Auto-reinvoke with Bash ----------------
if [ -z "${BASH_VERSION:-}" ]; then
    echo "⚠️ Not running in Bash. Re-invoking..."
    exec bash "$0" "$@"
fi

# ---------------- 1️⃣ Detect current login shell ----------------
CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
ZSH_PATH=$(command -v zsh)

echo "🔹 Current login shell: $CURRENT_SHELL"
echo "🔹 Detected Zsh path: $ZSH_PATH"

# ---------------- 2️⃣ Switch to Zsh if needed ----------------
if [[ "$CURRENT_SHELL" != "$ZSH_PATH" ]]; then
    echo "🔄 Changing default shell to Zsh..."
    if chsh -s "$ZSH_PATH" "$USER"; then
        echo "✅ Default shell changed successfully."
        echo "🔹 Updated login shell: $(getent passwd "$USER" | cut -d: -f7)"
        echo "Please log out and back in for the change to take effect."
    else
        echo "⚠️ Failed to change shell. You may need sudo:"
        echo "    sudo chsh -s \"$ZSH_PATH\" $USER"
        exit 1
    fi
else
    echo "✅ Zsh is already your default shell."
fi

# ---------------- 3️⃣ Install Oh My Zsh if missing ----------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🚀 Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "✅ Oh My Zsh installed."
else
    echo "ℹ️ Oh My Zsh is already installed."
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ---------------- 4️⃣ Clone custom plugins ----------------
declare -A PLUGINS_TO_CLONE=(
    ["zsh-bat"]="https://github.com/fdellwing/zsh-bat.git"
    ["you-should-use"]="https://github.com/MichaelAquilina/zsh-you-should-use.git"
    ["zsh-vi-mode"]="https://github.com/jeffreytse/zsh-vi-mode.git"
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

for plugin in "${!PLUGINS_TO_CLONE[@]}"; do
    PLUGIN_DIR="$ZSH_CUSTOM/plugins/$plugin"
    if [ ! -d "$PLUGIN_DIR" ]; then
        echo "🚀 Installing plugin $plugin..."
        git clone "${PLUGINS_TO_CLONE[$plugin]}" "$PLUGIN_DIR"
    else
        echo "ℹ️ Plugin $plugin already installed."
    fi
done

# ---------------- 5️⃣ Update .zshrc plugins line ----------------
ZSHRC="$HOME/.zshrc"
CUSTOM_PLUGINS="git zsh-bat you-should-use zsh-vi-mode zsh-autosuggestions zsh-syntax-highlighting"

if [ -f "$ZSHRC" ]; then
    # Only replace an existing, uncommented plugins line (handles leading spaces)
    if grep -q "^[[:space:]]*plugins=" "$ZSHRC"; then
        sed -i "s|^[[:space:]]*plugins=.*|plugins=($CUSTOM_PLUGINS)|" "$ZSHRC"
        echo "✅ Updated plugins line in .zshrc: $CUSTOM_PLUGINS"
    else
        echo "ℹ️ No active plugins line found in .zshrc. Nothing changed."
    fi
else
    echo "⚠️ .zshrc not found. Please check your Oh My Zsh installation."
fi

echo "🎉 Setup complete! Run 'source ~/.zshrc' or restart your terminal."
