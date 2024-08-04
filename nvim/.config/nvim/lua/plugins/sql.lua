return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod', lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
        'DB',
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()

        vim.g.db_ui_win_position = 'right'

        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1

        -- Save the query in specified location
        vim.g.db_ui_save_location = '~/database'

        -- Disable auto-execute on save
        vim.g.db_ui_execute_on_save = 0

        -- Uses nvim-notify for notifications
        vim.g.db_ui_use_nvim_notify = 1

        -- Maximum width of dad-bod ui
        vim.g.db_ui_winwidth = 30

        -- Add keymap for :DBUI
        vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>', { noremap = true, silent = true })

        -- Add keymap to run selected query in visual mode
        vim.keymap.set('v', '<leader>e', ":'<,'>DB<CR>", { noremap = true, silent = true })
        -- Set up autocmd for SQL file types
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {"sql", "mysql", "plsql"},
            callback = function()
                require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
            end
        })
    end,
}
