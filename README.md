# dotfiles

Place the dot files in the **home directory** and use `stow` command

```bash
#example for nvim
stow  nvim
```
- If you are placing the repo else where just specify `stow --target=$HOME package-name`

### Neovim

#### Plugins

1) **lsp-config.lua**
    - Currently has lsp's for 
        1) python - pyright
        2) c/c++ - clangd
        3) java - jdtls
        4) lua - lua_ls
        3) bash - bashls
    - Currently installed `linters`
        1) eslint_d -> js
        2) pylint, isort, black -> python 
    - As of now I am excluding the lsp's for **python**, **c++**, because the new plugin
        `dense-analysis/ale` is used to directly get the warnings and error message. (Found this one better than the errors and suggestions from the lsp's)
    - If you want to set the lsp's for checking the errors and warnings, follow these steps(mandate)
    1) uncomment the setup_servers local functions for both of them in lsp-config.lua
    2) in the dense-analysis.lua uncomment cpp and python inside the `vim.g.ale_linters` 
        **Even though gcc, g++ or clangd is set in dense-analysis.lua as linters they are not traditional linters**
For any of the languages do these steps if you want lsp's as the main configuration

