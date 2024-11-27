return {
	'Luxed/ayu-vim',
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		--load the colorscheme
		vim.cmd [[colorscheme ayu]]
	end,
}
