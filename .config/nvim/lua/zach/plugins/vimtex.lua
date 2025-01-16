return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	config = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method         = "zathura"
		vim.g.vimtex_compiler_method     = 'latexmk'
		vim.g.vimtex_mappings_prefix     = '<Space>l'
		-- Set latex flavor for vimtex
		vim.g.tex_flavor                 = 'latex'

		-- Set the viewer to Zathura
		vim.g.vimtex_view_method         = 'zathura'

		-- Set Vimtex to use SyncTeX for forward and inverse search
		vim.g.vimtex_view_forward_search = 1
		vim.g.vimtex_view_reverse_search = 1

		-- Disable quickfix mode for vimtex
		vim.g.vimtex_quickfix_mode       = 0

		-- Set conceal level
		vim.opt.conceallevel             = 0

		-- Set tex conceal characters
		vim.g.tex_conceal                = 'abdmg'
	end
}
