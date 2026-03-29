return {
    {
        "dense-analysis/ale",
        config = function()
            -- Enable ALE
            vim.g.ale_linters_explicit = 1
            -- Configure linters
            vim.g.ale_linters = {
                c = { "clang" },
                cpp = { "clang", "cppcheck" },  -- Added cppcheck for additional C++ diagnostics
                vim = { "vint" },
                css = { "stylelint" },
                html = { "htmlhint" },
                lua = { "luacheck" },
                python = { "pylint", "isort", "black" },
                javascript = { "eslint_d" },
                text = { "chktex" },
            }
            -- Configure fixers
            vim.g.ale_fixers = {
                python = { "isort", "black" },
                javascript = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                cpp = { "clang-format" }  -- Added clang-format for C++ fixing
            }
            -- Additional settings
            vim.g.ale_disable_lsp = 1  -- Disable ALE's LSP functionality
            vim.g.ale_sign_error = '✗'
            vim.g.ale_sign_warning = '∆'
            vim.g.ale_sign_info = 'ℹ'
            vim.keymap.set("n", "<leader>d", ":ALEDetail<CR>", {noremap = true, silent = true})

            -- Enable ALE for C and C++ files
            vim.g.ale_pattern_options = {
                ['.cpp$'] = {ale_enabled = 1},
                ['.hpp$'] = {ale_enabled = 1},
                ['.c$'] = {ale_enabled = 1},
                ['.h$'] = {ale_enabled = 1},
            }
        end,
    },
}
