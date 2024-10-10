return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },

    -- Nvim-tree keymaps
    config = function()
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
        vim.keymap.set('n', '<C-j>', ':Neotree toggle<CR>', {})
    end
}
