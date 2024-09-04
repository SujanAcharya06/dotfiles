return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            char = "│",
        },
        scope = { enabled = false },
        exclude = {
            filetypes = { "help", "dashboard", "neo-tree", "Trouble", "lazy" },
        },
    },
    config = function(_, opts)
        require("ibl").setup(opts)
        vim.cmd [[highlight IndentBlanklineChar guifg=#3c3836 gui=nocombine]]
    end,
}
