return {
    "mhinz/vim-grepper",
    lazy = false,
    config = function()
        -- Basic grepper setup
        vim.g.grepper = {
            tools = { "grep", "git", "rg" },
            highlight = 1,
            quickfix = 1,
            jump = 0
        }

        -- Preview function equivalent
        local function preview_quickfix_line()
            -- Guard against wrong buffer type
            if vim.bo.filetype ~= 'qf' then
                return
            end

            -- Get quickfix list safely
            local ok, qf_list = pcall(vim.fn.getqflist)
            if not ok or #qf_list == 0 then
                return
            end

            -- Get current line number safely
            local current_line = vim.fn.line('.')
            if current_line < 1 or current_line > #qf_list then
                return
            end

            -- Get current quickfix item
            local curr_item = qf_list[current_line]
            if not curr_item or not curr_item.bufnr then
                return
            end

            -- Store quickfix window ID
            local qf_winid = vim.fn.win_getid()

            -- Try to go to previous window
            vim.cmd('wincmd p')

            -- Ensure the buffer exists and is loaded
            if not vim.api.nvim_buf_is_valid(curr_item.bufnr) then
                vim.fn.win_gotoid(qf_winid)
                return
            end

            -- Get the line safely
            local ok2, lines = pcall(vim.api.nvim_buf_get_lines, curr_item.bufnr, curr_item.lnum - 1, curr_item.lnum,
                false)
            if not ok2 or #lines == 0 then
                vim.fn.win_gotoid(qf_winid)
                return
            end

            local line_length = #lines[1]

            -- Calculate safe column position
            local col = 0
            if curr_item.col and curr_item.col > 0 then
                col = math.min(curr_item.col - 1, math.max(0, line_length - 1))
            end

            -- Try to set cursor position
            local ok3 = pcall(vim.api.nvim_win_set_cursor, 0, { curr_item.lnum, col })
            if ok3 then
                vim.cmd('normal! zz')
            end

            -- Always return to quickfix window
            vim.fn.win_gotoid(qf_winid)
        end

        -- Set up autocommands
        local group = vim.api.nvim_create_augroup("GrepperPreview", { clear = true })

        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = "qf",
            callback = function()
                vim.api.nvim_create_autocmd("CursorMoved", {
                    group = group,
                    buffer = 0,
                    callback = function()
                        -- Wrap in pcall to prevent errors from propagating
                        pcall(preview_quickfix_line)
                    end
                })
            end
        })

        -- Open quickfix after grep
        vim.api.nvim_create_autocmd("User", {
            group = group,
            pattern = "Grepper",
            callback = function()
                vim.cmd('botright copen')
            end
        })

        -- Keymaps
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<leader>gg', ':Grepper<CR>', opts)
        vim.keymap.set('n', '<leader>ff', ':Grepper -buffer<CR>', opts)
        vim.keymap.set('n', 'gs', '<Plug>(GrepperOperator)', {})
        vim.keymap.set('x', 'gs', '<Plug>(GrepperOperator)', {})
        vim.keymap.set('n', '<leader>*', ':Grepper -cword -noprompt<CR>', opts)
    end
}
