return {
  {
    "tpope/vim-fugitive",
    config = function()
      local git_window_open = false
      local git_window_bufnr = nil
      local git_win_id = nil

      local function toggle_git_window()
        if git_window_open then
          if git_window_bufnr and vim.api.nvim_buf_is_valid(git_window_bufnr) then
            vim.api.nvim_buf_delete(git_window_bufnr, { force = true })
          end
          git_window_open = false
          git_window_bufnr = nil
          git_win_id = nil
        else
          vim.cmd("vert Git")
          git_window_open = true
          git_window_bufnr = vim.api.nvim_get_current_buf()
          git_win_id = vim.api.nvim_get_current_win()

          -- Set fixed width to half of screen width
          local screen_width = vim.api.nvim_get_option("columns")
          local git_width = math.floor(screen_width / 3)
          vim.api.nvim_win_set_width(git_win_id, git_width)

          -- Make window width fixed (prevent resizing)
          vim.api.nvim_win_set_option(git_win_id, "winfixwidth", true)

          -- Add q keymap to close the fugitive window (buffer-local)
          vim.keymap.set("n", "q", function()
            if git_window_open then
              -- Close the window and delete the buffer
              if git_win_id and vim.api.nvim_win_is_valid(git_win_id) then
                vim.api.nvim_win_close(git_win_id, false)
              end
              if git_window_bufnr and vim.api.nvim_buf_is_valid(git_window_bufnr) then
                vim.api.nvim_buf_delete(git_window_bufnr, { force = true })
              end
              git_window_open = false
              git_window_bufnr = nil
              git_win_id = nil
            end
          end, { noremap = true, silent = true, buffer = git_window_bufnr })
        end
      end

      vim.keymap.set("n", "<leader>gt", toggle_git_window, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gcm", ":Git commit<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gl", ":vert Git log --oneline<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gP", ":Git push -f origin main<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ga", ":Git commit --amend<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gn", ":Git commit --amend --no-edit<CR>", { noremap = true, silent = true })
    end,
  },
}
