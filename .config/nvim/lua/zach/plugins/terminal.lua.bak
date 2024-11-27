return {
	'numToStr/FTerm.nvim',
	config = function()
		require 'FTerm'.setup({
			-- Example keybindings
			vim.keymap.set('n', '<Space><CR>', '<CMD>lua require("FTerm").toggle()<CR>'),
			vim.keymap.set('t', '<Space>m', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>'),
			vim.keymap.set('t', '<Space>q', '<C-\\><C-n><CMD>lua require("FTerm").exit()<CR>')
		})
	end
}
