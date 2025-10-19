

#!/bin/bash
set -euo pipefail

# ----------------------------
# 0️⃣ Ensure user PATH includes ~/.local/bin
# ----------------------------
export PATH="$HOME/.local/bin:$PATH"

# ----------------------------
# 1️⃣ Install AdwaitaMono Nerd Font
# ----------------------------
FONT_DIR="$HOME/.local/share/fonts/AdwaitaMono"
mkdir -p "$FONT_DIR"

if [ -z "$(ls -A "$FONT_DIR" 2>/dev/null)" ]; then
    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR"

    FONT_ZIP="AdwaitaMono.zip"
    echo "⬇️ Downloading AdwaitaMono Nerd Font..."
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/AdwaitaMono.zip

    echo "📂 Extracting fonts..."
    unzip -oq "$FONT_ZIP" -d "$FONT_DIR"

    echo "🔄 Updating font cache..."
    fc-cache -fv "$HOME/.local/share/fonts"

    cd ~
    rm -rf "$TMP_DIR"

    echo "✅ AdwaitaMono Nerd Font installed for user $USER."
else
    echo "ℹ️ AdwaitaMono Nerd Font already installed, skipping."
fi

# ----------------------------
# 2️⃣ Set GNOME Terminal font
# ----------------------------
PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
CURRENT_FONT=$(gsettings get "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/" font | tr -d "'")
TARGET_FONT="AdwaitaMono Nerd Font 12"

if [ "$CURRENT_FONT" != "$TARGET_FONT" ]; then
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/" font "$TARGET_FONT"
    echo "✅ Terminal font set to $TARGET_FONT"
else
    echo "ℹ️ Terminal font already set to $TARGET_FONT"
fi

# ----------------------------
# 3️⃣ Install Oh My Posh
# ----------------------------
if ! command -v oh-my-posh >/dev/null 2>&1; then
    echo "⬇️ Installing Oh My Posh for current user..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
else
    echo "ℹ️ Oh My Posh already installed."
fi

# ----------------------------
# 4️⃣ Add Oh My Posh initialization to .zshrc
# ----------------------------
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    if ! grep -q "oh-my-posh init zsh" "$ZSHRC"; then
        echo -e "\n# Initialize Oh My Posh\neval \"\$(oh-my-posh init zsh)\"" >> "$ZSHRC"
        echo "✅ Oh My Posh initialization added to $ZSHRC"
    else
        echo "ℹ️ Oh My Posh already initialized in $ZSHRC"
    fi
else
    echo "⚠️ $ZSHRC not found. Please ensure Zsh and Oh My Zsh are installed."
fi

echo "🎉 Setup complete! Run 'source ~/.zshrc' or restart your terminal."
