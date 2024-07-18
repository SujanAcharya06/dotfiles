return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            -- Existing configuration...

            -- Set a specific port (uncomment to use)
            -- vim.g.mkdp_port = '8888'

            -- Automatically close the browser window when the Markdown buffer is closed
            vim.g.mkdp_auto_close = 1

            -- Echo the preview URL when it's opened (helpful for debugging)
            vim.g.mkdp_echo_preview_url = 1

            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_command_for_global = 0
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_open_ip = ''
            vim.g.mkdp_browser = ''
            vim.g.mkdp_echo_preview_url = 0
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
            vim.cmd[[
        augroup MarkdownPreviewAutoclose
        autocmd!
        autocmd VimLeavePre * :MarkdownPreviewStop
        augroup END
        ]]

        end,
    }
}
