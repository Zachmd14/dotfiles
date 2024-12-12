return {
	'saghen/blink.cmp',
	lazy = false, -- lazy loading handled internally
	-- optional: provides snippets for the snippet source
	dependencies = 'rafamadriz/friendly-snippets',

	-- use a release tag to download pre-built binaries
	version = 'v0.*',
	-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',

	opts = {
		highlight = {
			-- sets the fallback highlight groups to nvim-cmp's highlight groups
			-- useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release, assuming themes add support
			use_nvim_cmp_as_default = true,
		},
		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- adjusts spacing to ensure icons are aligned
		nerd_font_variant = 'normal',

		-- experimental auto-brackets support
		-- accept = { auto_brackets = { enabled = true } }

		-- experimental signature help support
		-- trigger = { signature_help = { enabled = true } }
		-- for keymap, all values may be string | string[]
		-- use an empty table to disable a keymap
		keymap = {
			["<C-c>"] = { "show" },
			["<C-CR>"] = { "hide" },
			["<S-m>"] = { "select_and_accept", "fallback" },
			["<S-k>"] = { "select_next", "fallback" },
			["<S-l>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<PageDown>"] = { "scroll_documentation_down" },
			["<PageUp>"] = { "scroll_documentation_up" },
		},

		kind_icons = {
			Text = '󰉿',
			Method = '󰊕',
			Function = '󰊕',
			Constructor = '󰒓',

			Field = '󰜢',
			Variable = '󰆦',
			Property = '󰖷',

			Class = '󱡠',
			Interface = '󱡠',
			Struct = '󱡠',
			Module = '󰅩',

			Unit = '󰪚',
			Value = '󰦨',
			Enum = '󰦨',
			EnumMember = '󰦨',

			Keyword = '󰻾',
			Constant = '󰏿',

			Snippet = '󱄽',
			Color = '󰏘',
			File = '󰈔',
			Reference = '󰬲',
			Folder = '󰉋',
			Event = '󱐋',
			Operator = '󰪚',
			TypeParameter = '󰬛',
		},
		fuzzy = {
			-- frencency tracks the most recently/frequently used items and boosts the score of the item
			use_frecency = true,
			-- proximity bonus boos
		},
	}
}
