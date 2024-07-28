
#!/bin/bash

echo "This script installs the dependency packages"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install oh-my-zsh
install_oh_my_zsh() {
    if ! command_exists zsh; then
        echo "Zsh is not installed. Installing Zsh..."
        sudo apt install -y zsh
    fi

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "Reloading terminal..."
        exec zsh
    else
        echo "oh-my-zsh is already installed."
    fi
}

# Function to install fzf
install_fzf() {
    if ! command_exists fzf; then
        echo "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    else
        echo "fzf is already installed."
    fi
}

add_configuration() {
    packages=("nvim" "vim" "tmux" "zsh" "bash")

    for pkg in "${packages[@]}"; do
        if [[ -d ./"$pkg" ]]; then
            read -p "Do you want to stow config for $pkg? (y/n) " choice
            case $choice in
                [Yy][Ee][Ss]* | [Yy] | [Yy ]*)
                    if [[ $pkg == "zsh" ]]; then
                        echo "aliases.zsh will not be stowed by default, stow it only if necessary"
                        stow --target=$HOME --ignore=".aliases.zsh" $pkg
                    else
                        stow --target=$HOME $pkg
                    fi
                    echo "Done..."
                    sleep 1
                    ;;
                [Nn][Oo]* | [Nn]*)
                    echo "Skipping..."
                    ;;
                *)
                    echo "Invalid input, skipping..."
                    ;;
            esac
        else
            echo "No config dir found for $pkg"
        fi
    done
}

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Install fzf
install_fzf

# Install oh-my-zsh
install_oh_my_zsh

# Stowing the configurations
add_configuration

# Clean up
echo "Clean Up"
sudo apt autoremove -y
sudo apt clean

echo "Installation completed. You may need to restart your terminal for all changes to take effect."

