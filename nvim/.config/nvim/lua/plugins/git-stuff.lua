return {
    {
        "tpope/vim-fugitive",
        config = function()
            local git_window_open = false
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
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '🔺' },
                    topdelete    = { text = '➖' },
                    changedelete = { text = '◢' },
                    untracked    = { text = '◈' },
                },
                signs_staged = {
                    add          = { text = '✚' },
                    change       = { text = '✎' },
                    delete       = { text = '✖' },
                    topdelete    = { text = '🔻' },
                    changedelete = { text = '◣' },
                    untracked    = { text = '◇' },
                },
                signs_staged_enable = true,
            })
            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
            vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
        end,
    }
}
