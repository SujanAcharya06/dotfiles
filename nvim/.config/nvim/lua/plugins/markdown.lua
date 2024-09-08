return {
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        config = function()
            require('render-markdown').setup({
                -- Add any configuration options here if needed
            })

            -- Set up keymaps
            vim.keymap.set('n', '<leader>me', ':RenderMarkdown enable<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>md', ':RenderMarkdown disable<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>mt', ':RenderMarkdown toggle<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>mx', ':RenderMarkdown expand<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>mc', ':RenderMarkdown contract<CR>', { noremap = true, silent = true })
        end
    }
}
