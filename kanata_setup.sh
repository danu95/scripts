
#!/usr/bin/env bash

# 

set -euo pipefail

REPO="troo/kanata"
INSTALL_PATH="/usr/local/bin/kanata"
TMP_DIR="/tmp/kanata-install"

mkdir -p "$TMP_DIR"

echo "Fetching latest release info…"
API_URL="https://api.github.com/repos/$REPO/releases/latest"
LATEST_JSON="$TMP_DIR/latest.json"
curl -sL "$API_URL" -o "$LATEST_JSON"

LATEST_TAG=$(jq -r '.tag_name // empty' "$LATEST_JSON")
ASSET_URL=$(jq -r '.assets // [] | .[] | select(.name | test("linux.*zip$")) | .browser_download_url' "$LATEST_JSON")

if [[ -z "$LATEST_TAG" ]]; then
  echo "Error: Could not determine latest tag_name from release JSON."
  exit 1
fi

echo "Latest version: $LATEST_TAG"

if [[ -z "$ASSET_URL" ]]; then
  echo "Error: No Linux ZIP asset found in release assets."
  echo "Maybe this release has no assets (only source archive or tags)."
  exit 1
fi

# (rest of script follows — version check, download, unpack, install)
