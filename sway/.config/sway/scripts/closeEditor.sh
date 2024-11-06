#!/bin/bash

# Function to check if Vim or Neovim is running in the terminal
check_vim_running() {
    pgrep -f "vim|nvim" > /dev/null
}

# Function to prompt user using wofi
prompt_user() {
    choice=$(echo -e "Yes\nNo" | wofi --dmenu --prompt="Application is running. Close anyway?" --width=300 --height=100 --cache-file=/dev/null)
    if [ "$choice" = "Yes" ]; then
        swaymsg kill
    fi
}

# Get the current window's app_id (which should be "foot" for Foot terminal)
current_app_id=$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .app_id')

# Main logic
if [ "$current_app_id" = "foot" ]; then
    if check_vim_running; then
        prompt_user
    else
        swaymsg kill
    fi
else
    swaymsg kill
fi

