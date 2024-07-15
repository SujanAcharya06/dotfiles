vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- sets the padding from start of the number
vim.cmd("set number")
vim.cmd("set numberwidth=4")
vim.cmd("set relativenumber")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.termguicolors = true

-- Spell checking configuration
vim.opt.spelllang = "en_us"
vim.opt.spell = false  -- Spell checking is off by default

-- Keymaps for spell checking
vim.api.nvim_set_keymap('n', '<leader>s', ':set spell!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-]>', ']s', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-[>', '[s', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>c', '1z=', { noremap = true })

-- Lazy menu toggle
vim.api.nvim_set_keymap('n', '<leader>]', ':Lazy<CR>', {noremap = true})
