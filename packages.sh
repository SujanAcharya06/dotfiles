#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}This script installs the dependency packages${NC}"

sudo apt install -y stow exa xsel trash-cli tree bat ranger

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install oh-my-zsh
install_oh_my_zsh() {
    if ! command_exists zsh; then
        echo -e "${RED}Zsh is not installed. Installing Zsh...${NC}"
        sudo apt install -y zsh
    fi

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${GREEN}Installing oh-my-zsh...${NC}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo -e "${GREEN}Reloading terminal...${NC}"
        exec zsh
    else
        echo -e "${GREEN}oh-my-zsh is already installed.${NC}"
    fi
}

# Function to install tpm
install_tpm() {
    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        echo -e "${RED}Installing tpm${NC}"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        echo -e "${GREEN}Done${NC}"
    else
        echo -e "${GREEN}tpm already installed${NC}"
    fi
}

# Function to install fzf
install_fzf() {
    if ! command_exists fzf; then
        echo -e "${GREEN}Installing fzf...${NC}"
        sudo apt install -y fzf
        if [[ ! -d ~/.fzf ]]; then
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install
        else
            echo -e "${GREEN}~/.fzf dir exists. Skipping${NC}"
        fi
    else
        echo -e "${GREEN}fzf is already installed.${NC}"
    fi
}

add_configuration() {
    packages=("nvim" "vim" "tmux" "zsh" "bash")

    for pkg in "${packages[@]}"; do
        if [[ -d ./"$pkg" ]]; then
            read -p "Do you want to stow config for $pkg? (y/n) " choice
            case $choice in
                [Yy]*)
                    if [[ $pkg == "zsh" ]]; then
                        echo -e "${RED}aliases.zsh will not be stowed by default, stow it only if necessary${NC}"
                        sleep 1
                        stow --target=$HOME --ignore=".aliases.zsh" $pkg
                    else
                        stow --target=$HOME $pkg
                    fi
                    echo -e "${GREEN}Done...${NC}"
                    sleep 1
                    ;;
                [Nn][Oo]* | [Nn]*)
                    echo -e "${GREEN}Skipping...${NC}"
                    ;;
                *)
                    echo -e "${RED}Invalid input, skipping...${NC}"
                    ;;
            esac
        else
            echo -e "${RED}No config dir found for $pkg${NC}"
        fi
    done
}

backuprc() {
    if [[ -f ~/.bashrc ]]; then
        echo -e "${GREEN}~/.bashrc found. Moving it to ~/.bashrc.bkp${NC}"
        mv ~/.bashrc ~/.bashrc.bkp
    else
        echo -e "${RED}~/.bashrc not found. Continuing...${NC}"
    fi

    if [[ -f ~/.zshrc ]]; then
        echo -e "${GREEN}~/.zshrc found. Moving it to ~/.zshrc.bkp${NC}"
        mv ~/.zshrc ~/.zshrc.bkp
    else
        echo -e "${RED}~/.zshrc not found. Continuing...${NC}"
    fi
}

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Backup default .bashrc and .zshrc files
backuprc

# Install fzf
install_fzf

# Install tpm
install_tpm

# Install oh-my-zsh
install_oh_my_zsh

# Stowing the configurations
add_configuration

# Clean up
echo -e "${GREEN}Clean Up${NC}"
sudo apt autoremove -y
sudo apt clean

echo -e "${GREEN}Installation completed. You may need to restart your terminal for all changes to take effect.${NC}"

