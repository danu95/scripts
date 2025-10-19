

#!/usr/bin/env bash
# ---------------------------------------------------------
# zsh_setup.sh – Set Zsh as default shell, install Oh My Zsh,
# custom plugins, and Oh My Posh, safely handling sudo.
# ---------------------------------------------------------

set -euo pipefail

# ---------------- Auto-reinvoke with Bash ----------------
if [ -z "${BASH_VERSION:-}" ]; then
    echo "⚠️ Not running in Bash. Re-invoking..."
    exec bash "$0" "$@"
fi

# ---------------- Detect real user for sudo ----------------
if [ "$EUID" -eq 0 ] && [ -n "${SUDO_USER:-}" ]; then
    REAL_USER="$SUDO_USER"
    USER_HOME=$(eval echo "~$REAL_USER")
else
    REAL_USER="$USER"
    USER_HOME="$HOME"
fi
echo "🔹 Running user-specific actions for $REAL_USER ($USER_HOME)"

# ---------------- 1️⃣ Detect current login shell ----------------
CURRENT_SHELL=$(getent passwd "$REAL_USER" | cut -d: -f7)
ZSH_PATH=$(command -v zsh)

echo "🔹 Current login shell: $CURRENT_SHELL"
echo "🔹 Detected Zsh path: $ZSH_PATH"

# ---------------- 2️⃣ Switch to Zsh if needed ----------------
if [[ "$CURRENT_SHELL" != "$ZSH_PATH" ]]; then
    echo "🔄 Changing default shell to Zsh for $REAL_USER..."
    if chsh -s "$ZSH_PATH" "$REAL_USER"; then
        echo "✅ Default shell changed successfully."
        echo "🔹 Updated login shell: $(getent passwd "$REAL_USER" | cut -d: -f7)"
        echo "Please log out and back in for the change to take effect."
    else
        echo "⚠️ Failed to change shell. You may need sudo:"
        echo "    sudo chsh -s \"$ZSH_PATH\" $REAL_USER"
        exit 1
    fi
else
    echo "✅ Zsh is already the default shell for $REAL_USER."
fi

# ---------------- 3️⃣ Install Oh My Zsh if missing ----------------
if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
    echo "🚀 Installing Oh My Zsh for $REAL_USER..."
    RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "✅ Oh My Zsh installed."
else
    echo "ℹ️ Oh My Zsh is already installed for $REAL_USER."
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}"

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
ZSHRC="$USER_HOME/.zshrc"
CUSTOM_PLUGINS="git zsh-bat you-should-use zsh-vi-mode zsh-autosuggestions zsh-syntax-highlighting"

if [ -f "$ZSHRC" ]; then
    if grep -q "^[[:space:]]*plugins=" "$ZSHRC"; then
        sed -i "s|^[[:space:]]*plugins=.*|plugins=($CUSTOM_PLUGINS)|" "$ZSHRC"
        echo "✅ Updated plugins line in $ZSHRC: $CUSTOM_PLUGINS"
    else
        echo "ℹ️ No active plugins line found in $ZSHRC. Nothing changed."
    fi
else
    echo "⚠️ $ZSHRC not found. Please check your Oh My Zsh installation."
fi



# ---------------- 6️⃣ Initialize Oh My Posh ----------------
# Determine real user's home if running via sudo
if [ "$EUID" -eq 0 ] && [ -n "${SUDO_USER:-}" ]; then
    REAL_USER="$SUDO_USER"
    USER_HOME=$(eval echo "~$REAL_USER")
else
    REAL_USER="$USER"
    USER_HOME="$HOME"
fi

ZSHRC="$USER_HOME/.zshrc"

# Ensure ~/.local/bin is in PATH and add Oh My Posh init only once
if ! grep -q "oh-my-posh init zsh" "$ZSHRC"; then
    echo "⬇️ Adding Oh My Posh init to $ZSHRC for user $REAL_USER..."
    cat <<'EOF' >> "$ZSHRC"

# Ensure local bin is in PATH
export PATH="$HOME/.local/bin:$PATH"

# Initialize Oh My Posh if installed
if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init zsh)"
fi
EOF
    echo "✅ Oh My Posh added to $ZSHRC."
else
    echo "ℹ️ Oh My Posh already initialized in $ZSHRC."
fi


# ---------------- 🧩 Fix commented PATH line in .zshrc ----------------
ZSHRC="$USER_HOME/.zshrc"

if grep -q '^# *export PATH=\$HOME/bin:\$HOME/.local/bin:/usr/local/bin:\$PATH' "$ZSHRC"; then
    echo "🛠️  Uncommenting PATH line in $ZSHRC..."
    sed -i 's|^# *export PATH=\$HOME/bin:\$HOME/.local/bin:/usr/local/bin:\$PATH|export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH|' "$ZSHRC"
    echo "✅ PATH export line uncommented."
else
    echo "ℹ️ PATH line already active or not found — skipping."
fi



echo "🎉 Setup complete! Run 'source $ZSHRC' or restart your terminal."
