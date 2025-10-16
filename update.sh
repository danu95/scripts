#!/bin/bash

# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt upgrade -y

# Remove unused dependencies
sudo apt autoremove -y

# Clean up retrieved package files
sudo apt autoclean -y



