return {
	{
		"dense-analysis/ale",
		config = function()
			-- Enable ALE
			vim.g.ale_linters_explicit = 1
			-- Configure linters
			vim.g.ale_linters = {
				cpp = { "g++" },
				python = { "pylint", "isort", "black" },
				javascript = { "eslint_d" },
			}
			-- Configure fixers
			vim.g.ale_fixers = {
				python = { "isort", "black" },
			}
			vim.keymap.set("n", "<leader>d", ":ALEDetail<CR>", {noremap = true, silent = true})
		end,
	},
}
