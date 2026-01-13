#!/usr/bin/env bash

# ACHTUNG! der download läuft mehrere Stunden

# ============================================================
# System-wide TeX Live environment setup script (Debian/Unix)
# ------------------------------------------------------------
# 1. Detects the latest TeX Live installation in /usr/local/texlive
# 2. Detects the correct platform (e.g., x86_64-linux)
# 3. Creates /etc/profile.d/texlive.sh with PATH, MANPATH, INFOPATH
# 4. Makes that file executable so it's loaded for all users
# 5. Immediately sources the file so TeX Live is usable now
# ============================================================

PROFILE_SCRIPT="/etc/profile.d/texlive.sh"

# --- Step 1: Find the latest TeX Live year installed ---
# This looks inside /usr/local/texlive for directories like 2023, 2024, 2025
TEXLIVE_YEAR=$(ls -1 /usr/local/texlive | grep -E '^[0-9]{4}$' | sort -n | tail -1)

if [ -z "$TEXLIVE_YEAR" ]; then
  echo "No TeX Live installation found under /usr/local/texlive."
  exit 1
fi

# --- Step 2: Find the platform subdirectory ---
# TeX Live puts binaries under bin/<platform>, e.g. bin/x86_64-linux
TEXLIVE_BIN_DIR="/usr/local/texlive/$TEXLIVE_YEAR/bin"
if [ ! -d "$TEXLIVE_BIN_DIR" ]; then
  echo "No bin directory found in $TEXLIVE_BIN_DIR"
  exit 1
fi

# Use the first entry in bin/ as the platform (usually only one exists)
TEXLIVE_PLATFORM=$(ls -1 "$TEXLIVE_BIN_DIR" | head -1)

# Full paths
TEXLIVE_BIN="$TEXLIVE_BIN_DIR/$TEXLIVE_PLATFORM"
TEXLIVE_MAN="/usr/local/texlive/$TEXLIVE_YEAR/texmf-dist/doc/man"
TEXLIVE_INFO="/usr/local/texlive/$TEXLIVE_YEAR/texmf-dist/doc/info"

echo "Detected TeX Live $TEXLIVE_YEAR ($TEXLIVE_PLATFORM)"
echo "Creating $PROFILE_SCRIPT ..."

# --- Step 3: Write environment variables into /etc/profile.d/texlive.sh ---
# These exports will apply for all users when they log in
cat <<EOF | sudo tee $PROFILE_SCRIPT > /dev/null
# TeX Live $TEXLIVE_YEAR environment
export PATH=$TEXLIVE_BIN:\$PATH
export MANPATH=$TEXLIVE_MAN:\$MANPATH
export INFOPATH=$TEXLIVE_INFO:\$INFOPATH
EOF

# --- Step 4: Make it executable ---
sudo chmod +x $PROFILE_SCRIPT

# --- Step 5: Source it immediately in the current shell ---
# This makes TeX Live available *now* without logout/login
echo "Sourcing $PROFILE_SCRIPT ..."
# shellcheck disable=SC1090
source $PROFILE_SCRIPT

echo "Done."
echo "TeX Live $TEXLIVE_YEAR is now active."
echo "Check with: pdflatex --version"






