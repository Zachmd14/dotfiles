return {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
	opts = {
		heading = {
			enabled = true,
			sign = true,
			position = 'overlay',
			icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
			signs = { '󰫎 ' },
			width = 'full',
			left_margin = 0,
			left_pad = 0,
			right_pad = 0,
			min_width = 0,
			border = true,
			border_virtual = false,
			border_prefix = false,
			above = '▄',
			below = '▀',
			backgrounds = {
				'RenderMarkdownH1Bg',
				'RenderMarkdownH2Bg',
				'RenderMarkdownH3Bg',
				'RenderMarkdownH4Bg',
				'RenderMarkdownH5Bg',
				'RenderMarkdownH6Bg',
			},
			foregrounds = {
				'RenderMarkdownH1',
				'RenderMarkdownH2',
				'RenderMarkdownH3',
				'RenderMarkdownH4',
				'RenderMarkdownH5',
				'RenderMarkdownH6',
			},
		},
		paragraph = {
			-- Turn on / off paragraph rendering
			enabled = true,
			-- Amount of margin to add to the left of paragraphs
			-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
			left_margin = 0,
			-- Minimum width to use for paragraphs
			min_width = 0,
		},
		code = {
			-- Turn on / off code block & inline code rendering
			enabled = true,
			-- Turn on / off any sign column related rendering
			sign = true,
			-- Determines how code blocks & inline code are rendered:
			--  none:     disables all rendering
			--  normal:   adds highlight group to code blocks & inline code, adds padding to code blocks
			--  language: adds language icon to sign column if enabled and icon + name above code blocks
			--  full:     normal + language
			style = 'full',
			-- Determines where language icon is rendered:
			--  right: right side of code block
			--  left:  left side of code block
			position = 'left',
			-- Amount of padding to add around the language
			-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
			language_pad = 0,
			-- Whether to include the language name next to the icon
			language_name = true,
			-- A list of language names for which background highlighting will be disabled
			-- Likely because that language has background highlights itself
			-- Or a boolean to make behavior apply to all languages
			-- Borders above & below blocks will continue to be rendered
			disable_background = { 'diff' },
			-- Width of the code block background:
			--  block: width of the code block
			--  full:  full width of the window
			width = 'full',
			-- Amount of margin to add to the left of code blocks
			-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
			-- Margin available space is computed after accounting for padding
			left_margin = 0,
			-- Amount of padding to add to the left of code blocks
			-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
			left_pad = 0,
			-- Amount of padding to add to the right of code blocks when width is 'block'
			-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
			right_pad = 0,
			-- Minimum width to use for code blocks when width is 'block'
			min_width = 0,
			-- Determines how the top / bottom of code block are rendered:
			--  none:  do not render a border
			--  thick: use the same highlight as the code body
			--  thin:  when lines are empty overlay the above & below icons
			border = 'thin',
			-- Used above code blocks for thin border
			above = '▄',
			-- Used below code blocks for thin border
			below = '▀',
			-- Highlight for code blocks
			highlight = 'RenderMarkdownCode',
			-- Highlight for inline code
			highlight_inline = 'RenderMarkdownCodeInline',
			-- Highlight for language, overrides icon provider value
			highlight_language = nil,
		},
		dash = {
			-- Turn on / off thematic break rendering
			enabled = true,
			-- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'
			-- The icon gets repeated across the window's width
			icon = '─',
			-- Width of the generated line:
			--  <integer>: a hard coded width value
			--  full:      full width of the window
			width = 'full',
			-- Highlight for the whole line generated from the icon
			highlight = 'RenderMarkdownDash',
		},
		bullet = {
			-- Turn on / off list bullet rendering
			enabled = false,
			-- Replaces '-'|'+'|'*' of 'list_item'
			-- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
			-- If a function is provided both of these values are passed in using 1 based indexing
			-- If a list is provided we index into it using a cycle based on the level
			-- If the value at that level is also a list we further index into it using a clamp based on the index
			-- If the item is a 'checkbox' a conceal is used to hide the bullet instead
			icons = { '●', '○', '◆', '◇' },
			-- Replaces 'n.'|'n)' of 'list_item'
			-- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
			-- If a function is provided both of these values are passed in using 1 based indexing
			-- If a list is provided we index into it using a cycle based on the level
			-- If the value at that level is also a list we further index into it using a clamp based on the index
			ordered_icons = function(level, index, value)
				value = vim.trim(value)
				local value_index = tonumber(value:sub(1, #value - 1))
				return string.format('%d.', value_index > 1 and value_index or index)
			end,
			-- Padding to add to the left of bullet point
			left_pad = 1,
			-- Padding to add to the right of bullet point
			right_pad = 0,
			-- Highlight for the bullet icon
			highlight = 'RenderMarkdownBullet',
		},
	},
}
