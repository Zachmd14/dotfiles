return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Obsidian/mainVault/",
				overrides = {
					notes_subdir = "02 - Zettelkasten",
				},
			},

			vim.keymap.set('n', '<leader>of', ':ObsidianFollowLink<CR>', {}),
			vim.keymap.set('n', '<leader>oq', ':ObsidianQuickSwitch<CR>', {}),
			vim.keymap.set('n', '<leader>ot', ':ObsidianTOC<CR>', {}),
			vim.keymap.set('n', '<leader>og', ':ObsidianTags<CR>', {}),
			vim.keymap.set('n', '<leader>od', ':ObsidianToday<CR>', {}),
			vim.keymap.set('n', '<leader>op', ':ObsidianPasteImg<CR>', {}),
			vim.keymap.set('n', '<leader>or',
				':call system("find ~/Documents/Obsidian/mainVault/ -type f | awk -v var=$(($RANDOM)) "NR==var {print $0}" | xargs nvim")<CR>',
				{}),
			vim.keymap.set('n', '<leader>on',
				function()
					local title = vim.fn.input('Enter note title: ')
					if title ~= '' then
						vim.cmd('ObsidianNew ' .. title)
					else
						print('Title cannot be empty')
					end
				end, {})

		},

		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string

		note_id_func = function(title)
			if title ~= nil then
				-- If title is given, transform it into a valid file name and return it as the ID.
				return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If no title is given, fall back to generating an ID with 4 random letters or a timestamp.
				local suffix = ""
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
				return tostring(os.time()) .. "-" .. suffix
			end
		end,


		new_notes_location = "current_dir",
		attachments = {
			img_folder = "~/Documents/Obsidian/mainVault/",
		},

		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "01 - Daily Notes",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%B %-d, %Y",
			-- Optional, default tags to add to each new daily note created.
			default_tags = { "daily-notes" },
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "Daily template"
		},

		templates = {
			folder = "~/Documents/Obsidian/mainVault/99 -  Templates/",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},
	}
}
