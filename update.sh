#!/bin/bash

# Function to ask for confirmation
confirm() {
    local prompt="$1"
    while true; do
        read -p "$prompt [y/N]: " yn
        case $yn in
            [Yy]* ) return 0;;  # Return 0 (success) if yes
            * ) return 1;;      # Return 1 (failure) for no or invalid input
        esac
    done
}

# Update and pull from GitHub
git fetch
git pull

# Remove current configuration files
rm ./sway/config ./waybar/config ./waybar/style.css

# Copy base files
cp ./sway/base/base_config ./sway/config
cp ./waybar/base/base_config ./waybar/config
cp ./waybar/base/base_style.css ./waybar/style.css

# Ask for confirmation
if ! confirm "Do you want to apply laptop patches?"; then
    echo "Operation cancelled. Exiting."
    exit 0
fi

# If we've reached here, the user has confirmed
echo "Proceeding with the operation..."
# Apply laptop patches to Waybar
cd waybar
patch config < ./patches/laptop_config.patch
patch style.css < ./patches/laptop_style.patch

