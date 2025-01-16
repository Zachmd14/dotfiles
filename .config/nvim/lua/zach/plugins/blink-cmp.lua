return {
	'saghen/blink.cmp',
	lazy = false, -- lazy loading handled internally
	-- use a release tag to download pre-built binaries
	version = 'v0.*',
	-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',



	opts = {
		keymap = {
			["<C-c>"] = { "show" },
			["<C-CR>"] = { "hide" },
			["<A-Space>"] = { "select_and_accept", "fallback" },
			["<C-k>"] = { "select_next", "fallback" },
			["<C-l>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<PageDown>"] = { "scroll_documentation_down" },
			["<PageUp>"] = { "scroll_documentation_up" },
		},
		fuzzy = {
			use_frecency = true,
		},
		snippets = { preset = 'luasnip' },
		sources = {
			default = { 'path', 'buffer', 'lsp', 'snippets' },
			cmdline = {},
		},
	}


}
