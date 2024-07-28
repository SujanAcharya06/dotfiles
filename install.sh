#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y build-essential curl wget git

# Install Vim
if ! command_exists vim; then
    echo -e "${GREEN}Installing Vim...${NC}"
    sudo apt install -y vim
else
    echo -e "${RED}Vim is already installed.${NC}"
fi

# Install Neovim
if ! command_exists nvim; then
    echo -e "${GREEN}Installing Neovim...${NC}"
    sudo apt install -y neovim
else
    echo -e "${RED}Neovim is already installed$.${NC}"
fi

# Install Tmux
if ! command_exists tmux; then
    echo -e "${GREEN}Installing Tmux...${NC}"
    sudo apt install -y tmux
else
    echo -e "${RED}Tmux is already installed$.${NC}"
fi

# Install Zsh
if ! command_exists zsh; then
    echo -e "${GREEN}Installing Zsh...${NC}"
    sudo apt install -y zsh
    if [ "$(basename "$SHELL")" != "zsh" ]; then
	    echo -e "${RED}Changing default shell to zsh...${NC}"
	    chsh -s $(which zsh)
	    echo -e "Default shell changed to zsh. Please log out and log back in to apply changes."
	    exec zsh
    fi
else
    echo -e "${RED}Zsh is already installed$.${NC}"
fi

# Clean up
sudo apt autoremove -y
sudo apt clean

echo -e "$(RED)Log out apply changes, shell changes"
