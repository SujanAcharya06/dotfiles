return {

    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup({ app = "google-chrome" })
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        config = function()
            require('render-markdown').setup({})

            vim.keymap.set('n', '<leader>me', ':RenderMarkdown enable<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>md', ':RenderMarkdown disable<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>mt', ':RenderMarkdown toggle<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>mx', ':RenderMarkdown expand<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>mc', ':RenderMarkdown contract<CR>', { noremap = true, silent = true })
        end
    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            -- You can set default image dir like this:
            -- dir_path = "images",
            -- use_absolute_path = false,
        },
        keys = {
            { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
    },
    -- {
    --     "3rd/image.nvim",
    --     config = function()
    --         require("image").setup()
    --     end
    -- }
}

