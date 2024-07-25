return {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
        -- Configure vim-visual-multi options here
        vim.g.VM_maps = {
            ["Find Under"] = "<C-d>",
            ["Find Subword Under"] = "<C-d>",
            ["Select All"] = "<C-a>",
            ["Add Cursor Up"] = "<C-Up>",
            ["Add Cursor Down"] = "<C-Down>",
            ["Select h"] = "<C-Left>",
            ["Select l"] = "<C-Right>",
        }

        -- Additional configuration options
        vim.g.VM_theme = "ocean"
        vim.g.VM_show_warnings = 1
        vim.g.VM_silent_exit = 1
    end,
}
