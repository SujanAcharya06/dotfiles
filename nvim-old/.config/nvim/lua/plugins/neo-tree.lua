-- return {
--     "nvim-neo-tree/neo-tree.nvim",
--     dependencies = {
--         "nvim-tree/nvim-web-devicons",
--         "nvim-lua/plenary.nvim",
--         "MunifTanjim/nui.nvim",
--     },
--
--     -- Nvim-tree keymaps
--     config = function()
--         vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
--         vim.keymap.set('n', '<C-j>', ':Neotree toggle<CR>', {})
--     end
-- }
--
return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },

    config = function()
        -- Keymaps
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
        vim.keymap.set('n', '<C-j>', ':Neotree toggle<CR>', {})

        -- Setup Neo-tree with trash delete
        require("neo-tree").setup({
            filesystem = {
                window = {
                    mappings = {
                        ["d"] = "delete",  -- Keep 'd' for delete, redefine behavior below
                    },
                },
                commands = {
                    delete = function(state)
                        local node = state.tree:get_node()
                        local path = node.path
                        -- Use trash-cli's trash-put
                        vim.fn.system({ "trash-put", path })
                        vim.notify("Moved to Trash: " .. path)
                        require("neo-tree.sources.manager").refresh(state.name)
                    end,
                },
            },
        })
    end
}
