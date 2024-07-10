return {
  {
    "tpope/vim-fugitive",
    config = function()
      -- Optional: Add some keymaps for Fugitive
      vim.keymap.set("n", "<leader>gs", ":vert Git<CR>", {noremap = true, silent = true})
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
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable = true,
      })
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
    end,
  }
}
