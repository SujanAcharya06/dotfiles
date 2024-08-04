return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require('nvim-autopairs.rule')
            npairs.setup({})

            -- Variable to track the state of autopairs
            _G.autopairs_enabled = true

            -- Function to toggle autopairs
            _G.toggle_autopairs = function()
                _G.autopairs_enabled = not _G.autopairs_enabled
                if _G.autopairs_enabled then
                    npairs.enable()
                    print("Autopairs enabled")
                else
                    npairs.disable()
                    print("Autopairs disabled")
                end
            end

            -- Set up the keybinding to toggle autopairs
            vim.api.nvim_set_keymap('n', '<C-i>', ':lua toggle_autopairs()<CR>', {noremap = true, silent = true})

            -- Override the toggle function of nvim-autopairs
            npairs.toggle = _G.toggle_autopairs
        end
    }
}
