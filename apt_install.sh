#!/bin/bash

PACKAGES=(
	libavcodec-extra
	libfuse2
	curl
	vlc
	flameshot
	audacity
	transmission
	vim
    zsh
	geany
	fzf
	btop
	bat
	lsd
	ripgrep
	vim-gtk3
	# die folgenden packete sind zum abspielen von medien in libre office usw.
	libgstreamer1.0-0
	gstreamer1.0-plugins-base
	gstreamer1.0-plugins-good
	gstreamer1.0-plugins-bad
	gstreamer1.0-plugins-ugly
	gstreamer1.0-libav
	gstreamer1.0-tools
	gstreamer1.0-x
	gstreamer1.0-alsa
	gstreamer1.0-gl
	gstreamer1.0-gtk3
	gstreamer1.0-qt5
	gstreamer1.0-pulseaudio
    # für neovim
)

echo "Updating package lists..."
sudo apt update -y

echo "Installing packages..."
for package in ${PACKAGES[@]}; do
	echo "Installing @package..."
	if sudo apt install -y "$package"; then
		echo "$package installed successfully."
	else
		echo "Failed to install $package."
	fi
done

echo "All done!"






