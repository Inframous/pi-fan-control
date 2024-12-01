#!/bin/bash

# Define the installation directory
INSTALL_DIR="/etc/fan_control"
SERVICE_FILE="/etc/systemd/system/fan_control.service"
PROFILE_FILE="/etc/profile.d/fan_control.sh"

# Stop the fan control service
echo "Stopping fan_control service..."
sudo systemctl stop fan_control.service

# Disable the service to prevent it from starting on boot
echo "Disabling fan_control service..."
sudo systemctl disable fan_control.service

# Remove the systemd service file
echo "Removing systemd service file..."
sudo rm -f "$SERVICE_FILE"

# Remove the files in /etc/fan_control
echo "Removing files from $INSTALL_DIR..."
sudo rm -rf "$INSTALL_DIR"

# Remove /etc/fan_control from PATH by deleting the profile file
echo "Removing /etc/fan_control from PATH..."
sudo rm -f "$PROFILE_FILE"

# Reload systemd to apply the changes
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Final message
echo "Uninstallation complete!"
