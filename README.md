# PWM Fan Control

This project provides a script for controlling PWM-based fans on a Raspberry Pi. The script runs as a service, controlling the fan speed using configurable parameters.(thresh-hold temp, fan speed)

## Features
- Control fan speed using PWM (Pulse Width Modulation).
- Run as a systemd service for automatic startup on boot.
- Configuration of the fan control through a simple script.

## Files
- `pwm_fan_control.py`: The main Python script that controls the fan speed.
- `config_fan_control.sh`: A script to configure fan control settings.
- `vars.env`: Environment file containing configurable parameters for fan control.

## Installation

To install the fan control system, follow these steps:

1. Clone the repository and cd into the folder:
    ```bash
    git clone https://github.com/Inframous/pi-fan-control.git
    cd pi-fan-control
    ```

2. Run the installation script:
   ```bash
   sudo bash install_fan_control.sh
   ```

## This script will:

- Copy the necessary files to /etc/fan_control.
- Set up a systemd service to run pwm_fan_control.py on boot.
- Add /etc/fan_control to your system's PATH for easy access.
- Once installed, you can configure the system by running:

This script allows you to configure the fan control parameters.

```bash
config_fan_control.sh
```

The service will now start automatically on boot. You can also start or stop it manually:
```bash
sudo systemctl start fan_control.service
sudo systemctl stop fan_control.service
```

To check the status of the service:
```bash
sudo systemctl status fan_control.service
```

To view logs of the service output:
```bash
sudo journalctl -u fan_control.service
```
To view real-time logs:
```bash
sudo journalctl -u fan_control.service -f
```

## Uninstallation
To uninstall the fan control system, follow these steps:

Run the uninstallation script:

```bash
sudo bash uninstall_fan_control.sh
```

This script will:

- Stop and disable the fan_control service.
- Remove all installed files from /etc/fan_control.
- Remove /etc/fan_control from the system PATH.
- After running the script, the fan control system will be fully removed from your system.


## License
This project is licensed under the MIT License - see the LICENSE file for details.
