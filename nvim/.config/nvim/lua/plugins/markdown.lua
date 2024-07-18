return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 0  -- This is the key change
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_command_for_global = 1  -- Allow the command to work outside markdown files
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_open_ip = ''
            vim.g.mkdp_browser = ''
            vim.g.mkdp_echo_preview_url = 1  -- Echo the server url for convenience
            vim.g.mkdp_browserfunc = ''
            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                maid = {},
                disable_sync_scroll = 0,
                sync_scroll_type = 'middle',
                hide_yaml_meta = 1,
                sequence_diagrams = {},
                flowchart_diagrams = {},
                content_editable = true,
                disable_filename = 0,
                toc = {}
            }
            vim.g.mkdp_markdown_css = ''
            vim.g.mkdp_highlight_css = ''
            vim.g.mkdp_port = ''
            vim.g.mkdp_page_title = '「${name}」'
            vim.g.mkdp_filetypes = { 'markdown' }
            vim.g.mkdp_theme = 'dark'

            -- Set up keymaps
            vim.api.nvim_set_keymap('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', { noremap = true, silent = true })

            -- Autocommand to stop preview when leaving Neovim
            vim.cmd[[
                augroup MarkdownPreviewAutoclose
                    autocmd!
                    autocmd VimLeavePre * :MarkdownPreviewStop
                augroup END
            ]]
        end,
    }
}
