#!/usr/bin/bash

read -p "Have you moved dofiles to a different location?(y/n)" choice
case $choice in
    [Yy]*)
        [[ -f ~/.vimrc ]] && rm ~/.vimrc
        [[ -d ~/.vim/autoload ]] && rm -r ~/.vim/autoload
        [[ -d ~/.vim/colors ]] && rm -r ~/.vim/colors
        [[ -f ~/.vimrc.minimal ]] && rm ~/.vimrc.minimal
        [[ -d ~/.config/nvim ]] && rm -r ~/.config/nvim
        [[ -f ~/.zshrc ]] && rm ~/.zshrc
        [[ -d ~/.oh-my-zsh/custom ]] && rm -r ~/.oh-my-zsh/custom
        [[ -f ~/.aliases.zsh ]] && rm ~/.aliases.zsh
        [[ -f ~/.lazy-load.zsh ]] && rm ~/.lazy-load.zsh
        [[ -f ~/.tmux.conf ]] && rm ~/.tmux.conf
        ;;
    [Nn]*)
        echo -e "Please move the dotfiles to different location to avoid removing it in the version control"
        ;;
    *)
        echo -e "Invalid input!! Exit"
        ;;
esac
