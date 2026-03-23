return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      -- Disable main class scanning - it fails for standalone files
      -- and causes the IndexOutOfBoundsException
      dap_main = false,

      root_dir = function(fname)
        local util = require("lspconfig.util")
        return util.root_pattern("pom.xml", "build.gradle", "build.gradle.kts", ".project", "src/main/java", ".git")(
          fname
        ) or vim.fn.fnamemodify(fname, ":h")
      end,

      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = "/usr/lib/jvm/jdk-21.0.7-oracle-x64",
                default = true,
              },
            },
          },
        },
      },
    },
  },
}
