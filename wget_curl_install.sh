#!/bin/bash

# hier werden mehere applikationen mit wget oder curl installiert. 

set -e

# Zotero
wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash

sudo apt update && sudo apt install zotero -y

# Spotify
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg

echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt install spotify-client -y

# Joplin
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

# Standard Notes - das geht so mässig, eher webversion verenden für linux
wget -O standard-notes.AppImage "https://github.com/standardnotes/app/releases/download/%40standardnotes/desktop%403.198.5/standard-notes-3.198.5-linux-x86_64.AppImage"

chmod +x standard-notes.AppImage

# Signal
# NOTE: These instructions only work for 64-bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key:
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg;
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories:
wget -O signal-desktop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources;
cat signal-desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null

# 3. Update your package database and install Signal:
sudo apt update && sudo apt install signal-desktop -y

# VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo -e 'Types: deb\nURIs: https://download.vscodium.com/debs\nSuites: vscodium\nComponents: main\nArchitectures: amd64 arm64\nSigned-by: /usr/share/keyrings/vscodium-archive-keyring.gpg' \
| sudo tee /etc/apt/sources.list.d/vscodium.sources

sudo apt update && sudo apt install codium -y


# Draw.io
wget -O drawio-amd64-28.1.2.deb "https://release-assets.githubusercontent.com/github-production-release-asset/92443980/f231e53e-56d4-419e-a04f-ff0b366eb5e8?sp=r&sv=2018-11-09&sr=b&spr=https&se=2025-10-05T15%3A27%3A17Z&rscd=attachment%3B+filename%3Ddrawio-amd64-28.1.2.deb&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2025-10-05T14%3A26%3A22Z&ske=2025-10-05T15%3A27%3A17Z&sks=b&skv=2018-11-09&sig=7xH2ElEzxfgh%2FgH9A%2Fag5k6oDEFqn6pR5BJ%2BdAwAUU0%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc1OTY3Njk2NiwibmJmIjoxNzU5Njc1MTY2LCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.5X3R7o7Alx4vyNv-ATGbOPaBkjRC-uzriXod9gldPQQ&response-content-disposition=attachment%3B%20filename%3Ddrawio-amd64-28.1.2.deb&response-content-type=application%2Foctet-stream"

sudo apt install ./drawio-amd64-28.1.2.deb -y











