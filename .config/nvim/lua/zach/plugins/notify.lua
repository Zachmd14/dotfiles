return {
	'rcarriga/nvim-notify',
	config = function()
		require('notify').setup({
			timeout = 200,
		})
	end
}
