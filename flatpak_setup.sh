#!/bin/bash

# einfach flatpak via apt installieren
sudo apt install flatpak -y

# empfehlenswert, wenn gnome verwendet wird. ähnliches ist verfügbar für kde
sudo apt install gnome-software-plugin-flatpak -y

# jetzt noch das repo hinzufügen
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# damit die änderungen aktiv sind, braucht es einen reboot. 


