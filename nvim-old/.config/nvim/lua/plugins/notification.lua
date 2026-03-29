return {
    "rcarriga/nvim-notify",
    config = function()
        -- Local notification for git-related messages
        local notify = require("notify")
        notify.setup({
            top_down = true,
            render = "wrapped-compact",
            max_width = 35,
            max_height = 25,

        })
        -- Override the default vim.notify with nvim-notify
        vim.notify = notify
        vim.api.nvim_create_augroup("NotifyFileEvents", { clear = true })
        local function get_filename()
            -- return vim.fn.expand("%:t")
            return vim.fn.expand("%:p")
        end
        -- Table for keeping the files in the current session
        local opened_files = {}
        -- Table to keep track of the current git directories visited
        local git_directories = {}
        -- Table for not git directories
        local normal_directories = {}
        -- Function to return the directory with .git or cwd
        local function get_git_root_or_cwd()
            local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
            if vim.v.shell_error ~= 0 then
                local cwd = vim.fn.getcwd()
                return cwd, false
            end
            return git_root, true
        end
        vim.api.nvim_create_autocmd("BufReadPost", {
            group = "NotifyFileEvents",
            callback = function()
                local filename = get_filename()
                local fullpath = vim.fn.expand("%:p")
                if not opened_files[fullpath] then
                    opened_files[fullpath] = true
                    notify("Opened file: " .. filename, "info", {
                        title = "File Opened",
                        timeout = 1000,
                    })
                end
                -- Get the root git directory path or cwd
                local path, is_git_root = get_git_root_or_cwd()
                if is_git_root then
                    if not git_directories[path] then
                        -- Mark visited git directories to avoid repeated notifications
                        git_directories[path] = true
                        notify("Inside git directory\n " .. path, "info", {
                            title = "Git Repository Detected",
                            timeout = 1000,
                        })
                    end
                else
                    if not normal_directories[path] then
                        -- Mark visited directories to avoid repeated notifications
                        normal_directories[path] = true
                        notify("Not in a git directory...\n " .. path, "info", {
                            title = "!Git Directory:",
                            timeout = 1000,
                        })
                    end
                end
            end
        })
        -- vim.api.nvim_create_autocmd("BufWritePost", {
        --     group = "NotifyFileEvents",
        --     callback = function()
        --         local filename = get_filename()
        --         notify("Saved file: " .. filename, "info", {
        --             title = "File Saved",
        --             timeout = 600,
        --         })
        --     end,
        -- })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = "NotifyFileEvents",
            callback = function()
                local fullpath = get_filename()
                local bufnr = vim.api.nvim_get_current_buf()
                local bytes = vim.fn.getfsize(fullpath)
                local lines = vim.api.nvim_buf_line_count(bufnr)

                -- Format message similar to Vim's output
                local msg = string.format('"%s" %dL, %dB written', fullpath, lines, bytes)

                notify(msg, "info", {
                    title = "File Saved",
                    timeout = 600,
                })
            end,
        })
    end,
}
