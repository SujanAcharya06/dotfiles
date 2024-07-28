#! /bin/bash

# Function to prompt for uninstallation
uninstall() {
    packages=("zsh" "vim" "neovim" "tmux")

    for pkg in "${packages[@]}"; do
        if command_exists "$pkg"; then
            read -p "Do you want to uninstall $pkg? (y/n) " response
            case "$response" in
                [Yy]* )
                    echo "Uninstalling $pkg..."
                    sudo apt remove -y "$pkg"
                    ;;
                [Nn]* )
                    echo "Skipping uninstallation of $pkg."
                    ;;
                * )
                    echo "Invalid input. Skipping uninstallation of $pkg."
                    ;;
            esac
        else
            echo "$pkg is not installed."
        fi
    done

    # Clean up after uninstallation
    sudo apt autoremove -y
    sudo apt clean
}

uninstall

echo "Completed"

