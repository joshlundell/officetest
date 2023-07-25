#!/bin/bash

# Grammarly DMG URL
GRAMMARLY_DMG_URL="https://download-mac.grammarly.com/Grammarly.dmg"

# Download the Grammarly DMG file
echo "Downloading Grammarly DMG..."
curl -O "$GRAMMARLY_DMG_URL"

# Mount the DMG file
echo "Mounting Grammarly DMG..."
hdiutil attach grammarly.dmg

# Locate the Grammarly Installer and run it
echo "Installing Grammarly..."
installer_path=$(find /Volumes/Grammarly -name "Grammarly Installer.app" -type d -maxdepth 1)
if [[ -n "$installer_path" ]]; then
    "$installer_path/Contents/MacOS/Grammarly Installer" -silent
else
    echo "Grammarly Installer not found on the mounted volume."
fi

# Clean up - unmount the DMG
echo "Cleaning up..."
hdiutil detach /Volumes/Grammarly

# Remove the downloaded DMG
rm grammarly.dmg

# Set permissions for Grammarly
echo "Setting permissions for Grammarly..."
# Replace the paths below with the actual paths where Grammarly is installed.
grammarly_app_path="/Applications/Grammarly.app"
grammarly_app_support_path="/Library/Application Support/Grammarly"

# Set permissions for the Grammarly app
chmod -R 755 "$grammarly_app_path"

# Set permissions for the Grammarly Application Support directory
chmod -R 755 "$grammarly_app_support_path"

echo "Grammarly installation completed."
