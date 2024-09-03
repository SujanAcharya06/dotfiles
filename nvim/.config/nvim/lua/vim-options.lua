vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
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
-- vim.api.nvim_set_keymap('n', '<C-]>', ']s', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-[>', '[s', { noremap = true })
-- Key map to automatically correct the spelling
vim.api.nvim_set_keymap('n', '<leader>c', '1z=', { noremap = true })

-- Lazy menu toggle
vim.api.nvim_set_keymap('n', '<leader>]', ':Lazy<CR>', {noremap = true})

-- Resize splits using Alt key
-- vim.api.nvim_set_keymap('n', '<A-h>', ':resize +2<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-l>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-,>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-.>', ':vertical resize +2<CR>', { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "BorderBG", { fg = "#3e4451", bg = "#282c34" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#98c379", fg = "#282c34" })

-- vim.opt.guicursor = "i:block-blinkwait1000-blinkon500-blinkoff500";
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,"..
    "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"..
    "sm:block-blinkwait175-blinkoff150-blinkon175";
