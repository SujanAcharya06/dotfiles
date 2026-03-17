-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
vim.api.nvim_create_autocmd("CompleteChanged", {
  callback = function()
    vim.api.nvim_set_hl(0, "MiniSnippetsCurrent", {})
    vim.api.nvim_set_hl(0, "MiniSnippetsNodes", {})
  end,
})

vim.api.nvim_create_autocmd("CompleteDone", {
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_set_hl(0, "MiniSnippetsCurrent", {})
      vim.api.nvim_set_hl(0, "MiniSnippetsNodes", {})
      vim.cmd("redraw")
    end, 50)
  end,
})
