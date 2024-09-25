return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = function()
		local logo = [[
	   ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
	   ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
	   ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
	   ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
	   ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
	   ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
	]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		local opts = {
			theme = "doom",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
				-- stylua: ignore
				center = {
					{ action = "Telescope find_files",       desc = " Find file",        icon = " ", key = "f" },
					{ action = "ene | startinsert",          desc = " New file",         icon = " ", key = "n" },
					{ action = "Telescope oldfiles",         desc = " Recent files",     icon = " ", key = "r" },
					{ action = "Telescope live_grep",        desc = " Find text",        icon = " ", key = "g" },
					{ action = "e $MYVIMRC",                 desc = " Config",           icon = " ", key = "c" },
					{ action = "Lazy",                       desc = " Lazy",             icon = "󰒲 ", key = "l" },
					{ action = "qa",                         desc = " Quit",             icon = " ", key = "q" },
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
	dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
-- return {
--     "nvimdev/dashboard-nvim",
--     event = "VimEnter",
--     opts = {
--         theme = "doom",
--         config = {
--             header = {
--                 "                                   ",
--                 "                                   ",
--                 "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
--                 "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
--                 "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
--                 "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
--                 "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
--                 "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
--                 "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
--                 " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
--                 " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
--                 "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
--                 "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
--                 "                                   ",
--             },
--             center = {
--                 {
--                     icon = " ",
--                     icon_hl = "Title",
--                     desc = "Find File",
--                     desc_hl = "String",
--                     key = "f",
--                     keymap = "SPC f f",
--                     key_hl = "Number",
--                     action = "Telescope find_files"
--                 },
--                 {
--                     icon = " ",
--                     desc = "Recent Files",
--                     key = "r",
--                     keymap = "SPC f r",
--                     action = "Telescope oldfiles"
--                 },
--                 {
--                     icon = " ",
--                     desc = "New File",
--                     key = "n",
--                     keymap = "SPC c n",
--                     action = "enew"
--                 },
--                 {
--                     icon = " ",
--                     desc = "Quit Neovim",
--                     key = "q",
--                     keymap = "SPC q",
--                     action = "qa"
--                 },
--             },
--             disable_move,
--             footer = {"🚀 Day-1"}
--         }
--     },
--     dependencies = { {'nvim-tree/nvim-web-devicons'} }
-- }
