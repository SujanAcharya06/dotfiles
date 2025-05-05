#!/bin/bash

dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="$dir/$(date +'%Y-%m-%d_%H-%M-%S').jpg"

case "$1" in
  full)
    maim "$file"
    ;;
  window)
    maim --window "$(xdotool getactivewindow)" "$file"
    ;;
  select)
    maim --select "$file"
    ;;
esac

if [ -f "$file" ]; then
  notify-send "Screenshot saved" "$file"
fi
