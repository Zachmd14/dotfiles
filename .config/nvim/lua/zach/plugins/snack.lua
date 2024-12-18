return {
	"folke/snacks.nvim",
	opts = {
		dashboard = {
			sections = {
				{ section = "header", padding = 5 },
				{ section = "keys",   gap = 1,    padding = 1 },
				{
					action = ":ObsidianQuickSwitch",
					key = "o",
					desc = "Open Obsidian Note",
					icon = " ",
					gap = 1,
					padding = 1,
				},
				{ pane = 2, section = "terminal", cmd = "peaclock", hl = "header", padding = 1, indent = 4 },
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				-- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "hub status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{
					pane = 2,
					title = "Files View",
					section = "terminal",
					cmd = "exa --icons --group-directories-first --sort=extension",
					gap = 1,
					-- padding = 5,
				},
				{ section = "startup" },
			},
		},
	},
	-- Define the buffer and window locally
	buf = nil,
	win = nil,

	-- Function to open the floating window
	open_win = function()
		buf = vim.api.nvim_create_buf(false, true)

		vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

		local width = vim.api.nvim_get_option("columns")
		local height = vim.api.nvim_get_option("lines")

		local win_height = math.ceil(height * 0.8 - 4)
		local win_width = math.ceil(width * 0.8)

		local row = math.ceil((height - win_height) / 2 - 1)
		local col = math.ceil((width - win_width) / 2)

		local opts = {
			style = "minimal",
			relative = "editor",
			width = win_width,
			height = win_height,
			row = row,
			col = col,
			border = "rounded",
		}

		-- Open the window with the created buffer
		win = vim.api.nvim_open_win(buf, true, opts)
		vim.api.nvim_win_set_option(win, "cursorline", true)
	end,

	-- Function to load the file into the buffer
	view = function()
		vim.api.nvim_buf_set_option(buf, "modifiable", true)

		-- Get the full path to the file within your runtime path
		local file_path = vim.api.nvim_get_runtime_file("~/Documents/Obsidian/mainVault/TODO.md", false)[1]

		-- Use the $read command to insert the file's contents into the buffer
		vim.api.nvim_command("$read " .. file_path)

		vim.api.nvim_buf_set_option(buf, "modifiable", false)
	end,

	-- Combined function to open the floating window and view the file
	view_cat = function()
		require("myPlugin").open_win() -- Open the floating window
		require("myPlugin").view()   -- Load the file content
	end,

}
