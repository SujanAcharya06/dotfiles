return {
    {
        "tpope/vim-fugitive", config = function() local git_window_open = false
            local git_window_bufnr = nil

            local function toggle_git_window()
                if git_window_open then
                    if git_window_bufnr and vim.api.nvim_buf_is_valid(git_window_bufnr) then
                        vim.api.nvim_buf_delete(git_window_bufnr, { force = true })
                    end
                    git_window_open = false
                    git_window_bufnr = nil
                else
                    vim.cmd('vert Git')
                    git_window_open = true
                    git_window_bufnr = vim.api.nvim_get_current_buf()
                end
            end

            vim.keymap.set("n", "<leader>gs", toggle_git_window, {noremap = true, silent = true})
            vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", {noremap = true, silent = true})
            vim.keymap.set("n", "<leader>P", ":Git push<CR>", {noremap = true, silent = true})
            vim.keymap.set('n', '<leader>gl', ':vert Git log --oneline<CR>', { noremap = true, silent = true })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require('gitsigns')
            gitsigns.setup({
                signs = {
                    add          = { text = '+' },
                    change       = { text = '^' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged = {
                    add          = { text = '++' },
                    change       = { text = '^' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged_enable = true,
            })

            -- Helper function for mapping keys
            local function map(mode, lhs, rhs, opts)
                opts = opts or {}
                opts.silent = opts.silent ~= false
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- New keymaps
            map('n', '<leader>hs', gitsigns.stage_hunk)
            map('n', '<leader>hr', gitsigns.reset_hunk)
            map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
            map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
            map('n', '<leader>hS', gitsigns.stage_buffer)
            map('n', '<leader>hu', gitsigns.undo_stage_hunk)
            map('n', '<leader>hR', gitsigns.reset_buffer)
            map('n', '<leader>hp', gitsigns.preview_hunk)
            map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
            map('n', '<leader>hd', gitsigns.diffthis)
            map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
            map('n', '<leader>td', gitsigns.toggle_deleted)

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
    }
}
