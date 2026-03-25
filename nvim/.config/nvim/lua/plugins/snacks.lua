return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ["<C-x>"] = "set_root", -- Add this to manually set root with Ctrl+x
      },
    },
  },
}
