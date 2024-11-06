#!/bin/bash

WALLPAPERS_DIR="/home/sujanacharya/.config/sway/backgrounds"
RANDOM_WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)
swaymsg output "eDP-1" bg "$RANDOM_WALLPAPER" fill > /dev/null
