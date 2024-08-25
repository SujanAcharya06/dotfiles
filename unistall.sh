#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

remove_zsh(){
    if [[ -f ~/.zshrc ]]; then
        echo -e "${GREEN}~/.zshrc found. Moving it to ~/.zshrc.bkp${NC}"
        mv ~/.zshrc ~/.zshrc.bkp
    else
        echo -e "${RED}~/.zshrc not found. Continuing...${NC}"
    fi

    if [[ -f ~/.lazy-load.zsh ]]; then
        echo -e "${RED}Removing ~/.lazy-load.zsh${NC}"
        rm ~/.lazy-load.zsh
    else
        echo -e "${GREEN}~/.lazy-load.zsh not found${NC}"
    fi

    if [[ -f ~/.zsh_history ]]; then
        echo -e "${RED}Removing ~/.zsh_history${NC}"
        rm ~/.zsh_history
    else
        echo -e "${GREEN}~/.zsh_history not found${NC}"
    fi
}

# Function to prompt for uninstallation
uninstall() {
    packages=("zsh" "vim" "neovim" "tmux")

    for pkg in "${packages[@]}"; do
        if command_exists "$pkg"; then
            echo -e "${RED}Do you want to uninstall $pkg? (y/n) ${NC}"
            read -r response
            case "$response" in
                [Yy]* )
                    echo "Uninstalling $pkg..."
                    sudo apt remove -y "$pkg"

                    case "$pkg" in
                        "zsh")
                            echo -e "${RED}Changing shell to bash${NC}"
                            chsh -s /bin/bash
                            echo -e "${RED}You might have to re-login for changes to take effect${NC}"
                            sleep 1
                            echo -e "${RED}Do you want to remove existing ~/.zshrc and its components? (y/n)${NC}"
                            read -r choice
                            if [[ -z "$choice" || "$choice" =~ ^[Yy] ]]; then
                                remove_zsh
                            else 
                                echo -e "${GREEN}Skipping...${NC}"
                            fi
                            ;;
                        "vim")
                            echo -e "${RED}Do you want to remove ~/.vimrc file? (y/n)${NC}"
                            read -r choice
                            if [[ -z "$choice" || "$choice" =~ ^[Yy] ]]; then
                                if [[ -f ~/.vimrc ]]; then
                                    rm ~/.vimrc
                                    echo -e "${RED}Removed ~/.vimrc${NC}"
                                fi
                            else 
                                echo -e "${GREEN}Skipping...${NC}"
                            fi
                            ;;
                        "neovim")
                            if [[ -d /opt/nvim-linux64 ]]; then
                                echo -e "${RED}Found neovim in /opt. Do you want to remove it? (y/n)${NC}"
                                read -r choice
                                if [[ -z "$choice" || "$choice" =~ ^[Yy] ]]; then
                                    sudo rm -rf /opt/nvim-linux64
                                    echo -e "${RED}Done...${NC}" 
                                else
                                    echo -e "${GREEN}Skipping...${NC}"
                                fi
                            fi
                            echo -e "${RED}Do you want to remove ~/.config/nvim directory? (y/n)${NC}"
                            read -r choice
                            if [[ -z "$choice" || "$choice" =~ ^[Yy] ]]; then
                                if [[ -d ~/.config/nvim ]]; then
                                    rm -rf ~/.config/nvim
                                    echo -e "${RED}Removed ~/.config/nvim${NC}"
                                fi
                            else
                                echo -e "${GREEN}Skipping...${NC}"
                            fi
                            ;;
                        "tmux")
                            echo -e "${RED}Do you want to remove ~/.tmux.conf file? (y/n)${NC}"
                            read -r choice
                            if [[ -z "$choice" || "$choice" =~ ^[Yy] ]]; then
                                if [[ -f ~/.tmux.conf ]]; then
                                    rm ~/.tmux.conf
                                    echo -e "${RED}Removed ~/.tmux.conf${NC}"
                                fi
                            else
                                echo -e "${GREEN}Skipping...${NC}"
                            fi
                            ;;
                    esac
                    ;;
                [Nn]* )
                    echo -e "${GREEN}Skipping uninstallation of $pkg.${NC}"
                    ;;
                * )
                    echo -e "${RED}Invalid input. Skipping uninstallation of $pkg.${NC}"
                    ;;
            esac
        else
            echo -e "${GREEN}$pkg is not installed.${NC}"
        fi
    done

    # Clean up after uninstallation
    echo -e "${GREEN}Clean up${NC}"
    sudo apt autoremove -y
    sudo apt autoclean
}

uninstall
echo "Completed"
