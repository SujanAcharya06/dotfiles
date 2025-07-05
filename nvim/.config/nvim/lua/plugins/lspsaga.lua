return {
    "nvimdev/lspsaga.nvim",
    config = function()
        require("lspsaga").setup({
            lightbulb = {
                enable = false,       -- Disable lightbulb icon completely
                sign = true,
                virtual_text = true,
            },
        })

        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Lspsaga: Go to Definition" })
        vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", { desc = "Lspsaga: References" })
        -- vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Lspsaga: Code Action" })
    end
}

