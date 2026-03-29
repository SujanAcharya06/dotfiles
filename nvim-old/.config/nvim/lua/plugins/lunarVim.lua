return {
    {
        "LunarVim/bigfile.nvim",
        event = { "BufReadPre" },
        config = function()
            require("bigfile").setup({
                -- Size threshold in MiB (default: 2 MiB)
                filesize = 2,

                -- Pattern to match files or function for custom detection
                pattern = { "*" },

                -- Features to disable for big files
                features = {
                    "indent_blankline",
                    "illuminate",
                    "lsp",
                    "treesitter",
                    "syntax",
                    "matchparen",
                    "vimopts",
                    "filetype",
                },
            })

            -- Custom feature for additional optimizations
            local custom_optimizations = {
                name = "custom_optimizations",
                opts = {
                    defer = false, -- disable on BufReadPre
                },
                disable = function()
                    -- Additional optimizations for large files
                    vim.opt_local.spell = false
                    vim.opt_local.wrap = false
                    -- vim.opt_local.relativenumber = false
                    -- vim.opt_local.number = false
                    vim.opt_local.number = true
                    vim.opt_local.cursorline = false
                    vim.opt_local.cursorcolumn = false

                    -- Performance settings
                    vim.opt.lazyredraw = true
                    vim.opt.ttyfast = true
                    vim.opt.synmaxcol = 200
                    vim.opt.regexpengine = 1
                    vim.opt.showmatch = false
                    vim.opt.scrolljump = 5
                    vim.opt.sidescroll = 15
                    vim.opt.hlsearch = false

                    -- Notify user about optimizations
                    vim.notify("Big file detected. Performance optimizations applied.", vim.log.levels.INFO)
                end,
            }

            -- Add custom optimizations to features
            require("bigfile").setup({
                filesize = 2,
                pattern = { "*" },
                features = {
                    "indent_blankline",
                    "illuminate",
                    "lsp",
                    "treesitter",
                    "syntax",
                    "matchparen",
                    "vimopts",
                    "filetype",
                    custom_optimizations,
                },
            })

            -- Custom pattern function for extremely large files like rockyou.txt
            require("bigfile").setup({
                filesize = 1, -- Lower threshold for text files
                pattern = function(bufnr, filesize_mib)
                    local filename = vim.api.nvim_buf_get_name(bufnr)
                    local basename = vim.fn.fnamemodify(filename, ":t")

                    -- Special handling for known large files
                    if basename == "rockyou.txt" or string.match(basename, "%.log$") or filesize_mib > 10 then
                        return true
                    end

                    -- Use default filesize detection for other files
                    return false
                end,
                features = {
                    "indent_blankline",
                    "illuminate",
                    "lsp",
                    "treesitter",
                    "syntax",
                    "matchparen",
                    "vimopts",
                    "filetype",
                    custom_optimizations,
                },
            })

            -- Key mappings for better navigation in large files
            vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'Page down and center' })
            vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'Page up and center' })
            vim.keymap.set('n', 'G', 'Gzz', { desc = 'Go to end and center' })
            vim.keymap.set('n', 'gg', 'ggzz', { desc = 'Go to start and center' })

            -- Command to manually re-enable matchparen if needed
            vim.api.nvim_create_user_command("ReenableMatchParen", function()
                vim.cmd("DoMatchParen")
            end, { desc = "Re-enable matchparen after big file" })
        end,
    },
}
