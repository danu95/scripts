#!/usr/bin/env bash

PACKAGES=(
	io.appflowy.AppFlowy
	org.kde.krita
	org.gimp.GIMP
	com.obsproject.Studio
	org.inkscape.Inkscape
	org.kde.kdenlive
	com.github.flxzt.rnote
	com.github.xournalpp.xournalpp
	app.drey.Warp
	dev.geopjr.Tuba
	io.gitlab.adhami3310.Converter
	org.gnome.Solanum
	de.haeckerfelix.Shortwave
	net.nokyan.Resources
	de.schmidhuberj.DieBahn
	org.gnome.Podcasts
	org.gnome.World.PikaBackup
	com.belmoussaoui.Obfuscate
	info.febvre.Komikku
	io.gitlab.adhami3310.Impression
	com.github.finefindus.eyedropper
	org.gnome.design.Emblem
	com.belmoussaoui.Decoder
	com.github.huluti.Curtail
	dev.geopjr.Collision
	org.gnome.gitlab.somas.Apostrophe
	dev.linwood.butterfly
	com.adilhanney.saber
	org.kde.okular
	net.lutris.Lutris
	org.gnome.Connections
	org.torproject.torbrowser-launcher
    org.gnome.Boxes
)

echo "Updating package lists..." 
sudo apt update -y 

echo "Installing packages..." 
for package in ${PACKAGES[@]}; do 
    echo "Installing @package..." 
    if flatpak install flathub -y "$package"; 
    then echo "$package installed successfully." 
    else echo "Failed to install $package." 
    fi 
done 

echo "All done!"




