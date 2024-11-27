return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		require('dashboard').setup {
			theme = 'hyper',
			config = {
				mru = { limit = 5 },

				-- Header section with Hyper-style ASCII art
				header = {
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                     ]],
					[[       ████ ██████           █████      ██                     ]],
					[[      ███████████             █████                             ]],
					[[      █████████ ███████████████████ ███   ███████████   ]],
					[[     █████████  ███    █████████████ █████ ██████████████   ]],
					[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
					[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
					[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],

					-- [[																																				 	 ]],
					-- [[																																				   ]],
					-- [[	 ________    _______    ________   ___      ___  ___   _____ ______      ]],
					-- [[	|\   ___  \ |\  ___ \  |\   __  \ |\  \    /  /||\  \ |\   _ \  _   \    ]],
					-- [[	\ \  \\ \  \\ \   __/| \ \  \|\  \\ \  \  /  / /\ \  \\ \  \\\__\ \  \   ]],
					-- [[	 \ \  \\ \  \\ \  \_|/__\ \  \\\  \\ \  \/  / /  \ \  \\ \  \\|__| \  \  ]],
					-- [[	  \ \  \\ \  \\ \  \_|\ \\ \  \\\  \\ \    / /    \ \  \\ \  \    \ \  \ ]],
					-- [[	   \ \__\\ \__\\ \_______\\ \_______\\ \__/ /      \ \__\\ \__\    \ \__\]],
					-- [[	    \|__| \|__| \|_______| \|_______| \|__|/        \|__| \|__|     \|__|]],
					-- [[	                                                                         ]],
					-- [[	                                                                         ]],
					-- [[	                                                                         ]],
				},

				-- Center menu with quick access actions
				shortcut = {
					{
						icon = ' ',
						icon_hl = 'Title',
						desc = 'Open File',
						desc_hl = 'String',
						key = 'f',
						keymap = '',
						key_hl = 'Number',
						key_format = ' %s', -- remove default surrounding `[]`
						action = ':execute "cd $PWD" | Telescope find_files'
					},
					-- {
					-- 	icon = ' ',
					-- 	icon_hl = 'Title',
					-- 	desc = 'Search Text',
					-- 	desc_hl = 'String',
					-- 	key = 's',
					-- 	keymap = '',
					-- 	key_hl = 'Number',
					-- 	key_format = ' %s',
					-- 	action = ':Telescope live_grep'
					-- },
					-- {
					-- 	icon = ' ',
					-- 	icon_hl = 'Title',
					-- 	desc = 'Open Terminal',
					-- 	desc_hl = 'String',
					-- 	key = 't',
					-- 	keymap = '',
					-- 	key_hl = 'Number',
					-- 	key_format = ' %s',
					-- 	action = ':terminal'
					-- },
					{
						icon = ' ',
						desc = 'Obsidian Vault',
						key = 'o',
						keymap = '',
						key_format = ' %s', -- remove default surrounding `[]`
						action = ':ObsidianQuickSwitch'
					},
					{
						icon = ' ',
						icon_hl = 'Title',
						desc = 'Edit Config',
						desc_hl = 'String',
						key = 'c',
						keymap = '',
						key_hl = 'Number',
						key_format = ' %s',
						action = 'Telescope find_files search_dirs=~/.config/nvim/'
					},
					{
						icon = ' ',
						icon_hl = 'Title',
						desc = 'Recent Files',
						desc_hl = 'String',
						key = 'r',
						keymap = '',
						key_hl = 'Number',
						key_format = ' %s',
						action = ':Telescope oldfiles'
					},
					-- {
					-- 	icon = ' ',
					-- 	icon_hl = 'Title',
					-- 	desc = 'Update Plugins',
					-- 	desc_hl = 'String',
					-- 	key = 'u',
					-- 	keymap = '',
					-- 	key_hl = 'Number',
					-- 	key_format = ' %s',
					-- 	action = ':Lazy update'
					-- },
					{
						icon = ' ',
						icon_hl = 'Title',
						desc = 'Quit Neovim',
						desc_hl = 'String',
						key = 'q',
						keymap = '',
						key_hl = 'Number',
						key_format = ' %s',
						action = ':q'
					},
					{
						icon = ' ',
						desc = 'Find Recent Projects',
						key = 'p',
						keymap = '',
						key_format = ' %s', -- remove default surrounding `[]`
						action = 'Telescope projects'
					},
				},

				-- Footer section with a simple message
				footer = {
					[[                                         ]],
					[[                                         ]],
					[[                                         ]],
					[[     "Stay productive, stay Hyper!"     ]],
					[[                                         ]],
				},
			},
		}
	end
}
