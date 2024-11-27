return {
	'ggandor/leap.nvim',
	config = function()
		vim.keymap.set({ 'n', 'x', 'o' }, 'h', '<Plug>(leap-forward)')
		vim.keymap.set({ 'n', 'x', 'o' }, 'H', '<Plug>(leap-backward)')
		vim.keymap.set({ 'n', 'x', 'o' }, 'gh', '<Plug>(leap-from-window)')
	end
}
