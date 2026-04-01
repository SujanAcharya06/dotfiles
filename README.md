# dotfiles

- Place the dot files in the **home directory** and use `stow` command

```bash
#example for nvim
stow  nvim
```

- If you are placing the repo else where just specify `stow --target=$HOME package-name`

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Command-time
git clone https://github.com/popstas/zsh-command-time.git $ZSH_CUSTOM/plugins/command-time
