return {
	'glepnir/template.nvim',
	cmd = { 'Template', 'TemProject' },
	config = function()
		require('template').setup({
			-- config in there
			temp_dir = '~/.config/nvim/templates/',
			author = 'Michalski-Debuys Zachary',
			email = 'zacharymd14@gmail.com',
		})
	end
}
