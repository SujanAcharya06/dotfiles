return {
	'mg979/vim-visual-multi',
	init = function()
		vim.g.VM_default_mappings = 0
		vim.g.VM_maps = {
			['Find Under'] = ''
		}
		vim.g.VM_add_cursor_at_pos_no_mappings = 1

		-- Define the visual_cursors_with_delay function
		local function visual_cursors_with_delay()
			vim.cmd('silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"')
			vim.cmd('sleep 200m')
			vim.cmd('silent! execute "normal! A"')
		end

		-- Set up the mappings
		vim.keymap.set('n', '<leader>ma', '<Plug>(VM-Select-All)', { noremap = true, silent = true, desc = "Select All" })
		vim.keymap.set('n', '<leader>mr', '<Plug>(VM-Start-Regex-Search)', { noremap = true, silent = true, desc = "Regex Search" })
		vim.keymap.set('n', '<leader>mp', '<Plug>(VM-Add-Cursor-At-Pos)', { noremap = true, silent = true, desc = "Add Cursor At Pos" })
		vim.keymap.set('v', '<leader>mc', visual_cursors_with_delay, { noremap = true, silent = true, desc = "Visual Cursors" })
		vim.keymap.set('n', '<leader>mo', '<Plug>(VM-Toggle-Mappings)', { noremap = true, silent = true, desc = "Toggle Mapping" })
	end,
}
