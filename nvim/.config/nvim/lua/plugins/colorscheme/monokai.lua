return {
    "tanvirtin/monokai.nvim",
    name = "monokai",
    priority = 1000,
    config = function()
        require('monokai').setup {
            palette = require('monokai').pro
        }
        -- vim.cmd.colorscheme('monokai')
    end
}
