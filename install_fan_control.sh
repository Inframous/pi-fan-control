#!/bin/bash

# Define the installation directory
INSTALL_DIR="/etc/fan_control"

# Create the directory if it does not exist
if [ ! -d "$INSTALL_DIR" ]; then
  echo "Creating directory $INSTALL_DIR..."
  sudo mkdir -p "$INSTALL_DIR"
fi

# Copy the files to /etc/fan_control
echo "Copying files to $INSTALL_DIR..."
sudo cp config_fan_control.sh pwm_fan_control.py vars.env "$INSTALL_DIR"

# Create a systemd service to start pwm_fan_control.py on boot
SERVICE_FILE="/etc/systemd/system/fan_control.service"

echo "Creating systemd service..."
sudo bash -c 'cat << EOF > '$SERVICE_FILE'
[Unit]
Description=PWM Fan Control Service
After=multi-user.target

[Service]
ExecStart=/usr/bin/python3 /etc/fan_control/pwm_fan_control.py
WorkingDirectory=/etc/fan_control
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd to apply the new service
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable the service to start on boot
echo "Enabling fan_control service..."
sudo systemctl enable fan_control.service

# Add /etc/fan_control to the PATH
echo "Adding /etc/fan_control to PATH..."
echo 'export PATH=$PATH:/etc/fan_control' | sudo tee -a /etc/profile.d/fan_control.sh

# Mention configuration steps to the user
echo "Installation complete! To configure the fan control system, please run the config_fan_control.sh script."
echo "You can start the fan control service with: sudo systemctl start fan_control.service"
