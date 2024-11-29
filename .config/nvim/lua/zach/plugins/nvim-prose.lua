return {
	'skwee357/nvim-prose',
	confg = function()
		require('nvim-prose').setup {
			wpm = 200.0,
			filetypes = { 'markdown', 'asciidoc' },
			placeholders = {
				words = 'words',
				minutes = 'min'
			}
		}
	end
}
