return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    notify.setup()

    -- Create an autocommand group
    vim.api.nvim_create_augroup("NotifyFileEvents", { clear = true })

    -- Function to get filename
    local function get_filename()
      return vim.fn.expand("%:t")
    end

    -- Create an autocommand for BufReadPost event (file open)
    vim.api.nvim_create_autocmd("BufReadPost", {
      group = "NotifyFileEvents",
      callback = function()
        local filename = get_filename()
        notify("Opened file: " .. filename, "info", {
          title = "File Opened",
          timeout = 3000,
        })
      end,
    })

    -- Create an autocommand for BufWritePost event (file save)
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = "NotifyFileEvents",
      callback = function()
        local filename = get_filename()
        notify("Saved file: " .. filename, "info", {
          title = "File Saved",
          timeout = 3000,
        })
      end,
    })

    -- -- Your existing async notification setup
    -- local async = require("plenary.async")
    -- async.run(function()
    --   notify("Let's wait for this to close").events.close()
    --   notify("It closed!")
    -- end)
  end,
}
