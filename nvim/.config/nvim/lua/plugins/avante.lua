return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",
    -- for example
    provider = "claude",
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
      moonshot = {
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-k2-0711-preview",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 32768,
        },
      },
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        -- model = "gemini-1.5-pro",
        model = "gemini-1.5-flash",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.5, -- 0.75
          top_k = 1,
          candidate_count = 1,
          max_output_tokens = 32768,
        },
      },
      ollama = {
        endpoint = "http://localhost:11434",
        model = "llama3.2:3b",
        timeout = 60000, -- Increase timeout
        extra_request_body = {
          temperature = 0.1, -- Lower for coding
          max_tokens = 4096, -- Reduce from 8192
          num_ctx = 4096, -- Limit context window
        },
      },
    },
  },
  config = function(_, opts)
    require("avante").setup(opts)

    -- Custom autocmd to set up buffer-local keymaps for Avante
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "Avante*",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        -- Only map 'q' in normal mode for Avante buffers
        vim.keymap.set("n", "q", function()
          vim.cmd("AvanteToggle")
        end, { buffer = buf, desc = "Close Avante" })
      end,
    })

    require("avante.api").generate_commit_message = function()
      local staged_diff = vim.fn.system("git diff --staged")
      local unstaged_diff = vim.fn.system("git diff")
      local diff = staged_diff ~= "" and staged_diff or unstaged_diff
      if diff == "" then
        vim.notify("No changes detected. Stage your changes first with 'git add'", vim.log.levels.WARN)
        return
      end
      local prompt = "Generate a commit message NOW. Do not respond with anything except the commit message itself.\n\n\
REQUIREMENTS:\n\
- Use commitizen convention\n\
- Title under 50 characters\n\
- Wrap at 72 characters\n\
- Format as gitcommit code block\n\
- No newlines between commit messages\n\
- One brief paragraph per file\n\
- If Demo in filename, ignore (understanding purpose only)\n\
- For multiple files, add body explaining each file\n\
- Mention time/space complexity if found in comments\n\
- Use 'impl' prefix for DSA problems, not 'feat'\n\
\n\
OUTPUT ONLY THE COMMIT MESSAGE IN A CODE BLOCK. NO OTHER TEXT.\n\n\
Git diff:\n" .. diff
      vim.fn.setreg("+", prompt)
      vim.notify("Commit message prompt copied to clipboard! Open Avante and paste with Ctrl+V", vim.log.levels.INFO)
      -- vim.schedule(function()
      --   vim.cmd("AvanteToggle")
      -- end)
    end
  end,
  keys = {
    {
      "<leader>agc",
      function()
        require("avante.api").generate_commit_message()
      end,
      desc = "Generate Commit Message with Avante",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
