#!/usr/bin/env bash
# !!! shebang für bash immer auf die erste Zeile!

# this script is based on this documentation: https://github.com/jtroo/kanata/blob/main/docs/setup-linux.md
# wir legen das kanta.kbd file an die korrekte stelle 
# und machen einen systemd service, der kanata automatisch startet

# === ERROR HANDLING ===
set -euo pipefail
# -e : Exit immediately if any command exits with a non-zero status
# -u : Treat unset variables as an error and exit
# -o pipefail : If any command in a pipeline fails, the whole pipeline fails

# === Log functions ===
log_event() {
    local message="$*"

    local timestamp
    timestamp="$(date -Is)"

    local user
    user="$(whoami)"

    local application
    application="$(basename "$0")"

    echo "message=${message}; timestamp=${timestamp}; user=${user}; application=${application}"
}

# === Configuration ===
# INSTALL_DIR=/home/daniel/.config/kanata
# BIN_LINK= TBD # Brauche ich vermutlich nicht, weil ich es nicht im available PATH fürs system brauche

# === Create the uinput group (if it doesn't exits) ===
log_event "Create the uinput group (if it doesn't exits)"
if ! getent group uinput >/dev/null; then
    sudo groupadd --system uinput
fi

# === Add your user to the input and uinput group ===
log_event "Add your user to the input and uinput group"
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

groups

# === Load the uinput kernel module ===
log_event "Load the uinput kernel module"
sudo modprobe uinput

# === Make sure the uinput device file has the right permissions ===
# Create the udev rule
log_event "Make sure the uinput device file has the right permissions"
sudo tee /etc/udev/rules.d/99-input.rules > /dev/null <<EOF
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
EOF
# Match the kernel device named "uinput"
# Set permissions to rw for owner and group (0660)
# Assign the device to the "uinput" group
# Ensure /dev/uinput is always created as a static node

# Reload udev rules
sudo udevadm control --reload-rules && sudo udevadm trigger
# Verify
ls -l /dev/uinput

# === Create and enable a systemd user service ===
log_event "Create and enable a systemd user service"
mkdir -p ~/.config/systemd/user

# === kanata.service ins korrekte dirctory kopieren ===
cp ~/git/scripts/kanata.service ~/.config/systemd/user/

# === run the commands to start it ===
log_event "run the commands to start it"
systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user start kanata.service
systemctl --user status kanata.service   # check whether the service is running














