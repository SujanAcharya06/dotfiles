return {
    {
        "startup-nvim/startup.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        -- themes
        -- dashboard (default)
        -- evil
        -- startify
        config = function()
            require("startup").setup({theme = "dashboard"})
        end
    }
}
-- return {
--   "goolord/alpha-nvim",
--   dependencies = {
--     "nvim-tree/nvim-web-devicons",
--   },
--
--   config = function()
--     local alpha = require("alpha")
--     local dashboard = require("alpha.themes.startify")
--
--     dashboard.section.header.val = {
--       [[                                                                       ]],
--       [[                                                                       ]],
--       [[                                                                       ]],
--       [[                                                                       ]],
--       [[                                                                     ]],
--       [[       ████ ██████           █████      ██                     ]],
--       [[      ███████████             █████                             ]],
--       [[      █████████ ███████████████████ ███   ███████████   ]],
--       [[     █████████  ███    █████████████ █████ ██████████████   ]],
--       [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
--       [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
--       [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
--       [[                                                                       ]],
--       [[                                                                       ]],
--       [[                                                                       ]],
--     }
--
--     alpha.setup(dashboard.opts)
--   end,
-- }
