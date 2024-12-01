#!/bin/bash

# Path to the vars.env file
VARS_FILE="vars.env"

# Function to update or add a key-value pair in vars.env
update_var() {
  local key=$1
  local value=$2
  if grep -q "^$key=" "$VARS_FILE"; then
    sed -i "s/^$key=.*/$key=$value/" "$VARS_FILE"
  else
    echo "$key=$value" >> "$VARS_FILE"
  fi
}

# Ensure vars.env file exists
if [ ! -f "$VARS_FILE" ]; then
  echo "vars.env file not found. Creating a new one."
  touch "$VARS_FILE"
fi

# Prompt for fan pin number
echo "Updating fan configuration in $VARS_FILE..."
read -p "Enter Fan Pin # (Default is 8): " FAN_PIN
if [ -z "$FAN_PIN" ]; then
    FAN_PIN=8
fi

# Prompt the user for temperature thresholds
read -p "Enter Phase 1 temperature threshold: " PHASE1_TEMP
read -p "Enter Phase 2 temperature threshold: " PHASE2_TEMP
read -p "Enter Phase 3 temperature threshold: " PHASE3_TEMP

# Prompt the user for fan speeds
read -p "Enter Phase 1 fan speed (0-100): " PHASE1_SPEED
read -p "Enter Phase 2 fan speed (0-100): " PHASE2_SPEED
read -p "Enter Phase 3 fan speed (0-100): " PHASE3_SPEED

# Update vars.env with user inputs
update_var "FAN_PIN" "$FAN_PIN"
update_var "PHASE1_TEMP" "$PHASE1_TEMP"
update_var "PHASE2_TEMP" "$PHASE2_TEMP"
update_var "PHASE3_TEMP" "$PHASE3_TEMP"
update_var "PHASE1_SPEED" "$PHASE1_SPEED"
update_var "PHASE2_SPEED" "$PHASE2_SPEED"
update_var "PHASE3_SPEED" "$PHASE3_SPEED"

echo "Updated $VARS_FILE:"
cat "$VARS_FILE"

