#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y build-essential curl wget git

# Install Zsh
if ! command_exists zsh; then
    echo "Installing Zsh..."
    sudo apt install -y zsh
else
    echo "Zsh is already installed."
fi

# Install Vim
if ! command_exists vim; then
    echo "Installing Vim..."
    sudo apt install -y vim
else
    echo "Vim is already installed."
fi

# Install Neovim
if ! command_exists nvim; then
    echo "Installing Neovim..."
    sudo apt install -y neovim
else
    echo "Neovim is already installed."
fi

# Install Tmux
if ! command_exists tmux; then
    echo "Installing Tmux..."
    sudo apt install -y tmux
else
    echo "Tmux is already installed."
fi

# Clean up
sudo apt autoremove -y
sudo apt clean
