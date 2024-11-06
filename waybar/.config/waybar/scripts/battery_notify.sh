#!/bin/bash

# Set the threshold percentage for notifications
MIN_THRESHOLD=20
MAX_THRESHOLD=80

# Get the current battery level and status
BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)

# Trigger notification if battery is below the threshold and discharging
if [[ "$BATTERY_STATUS" == "Discharging" && "$BATTERY_LEVEL" -le "$MIN_THRESHOLD" ]]; then
    dunstify -u critical "Battery Low" "Battery level is at ${BATTERY_LEVEL}%"
fi

# Trigger notification if battery is above the threshold and discharging
if [[ "$BATTERY_STATUS" == "Charging" && "$BATTERY_LEVEL" -ge "$MAX_THRESHOLD" ]]; then
    dunstify "Battery level is at ${BATTERY_LEVEL}%" "Remove the charger!!"
fi
