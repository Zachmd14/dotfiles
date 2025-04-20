local ltw = require("little-taskwarrior")
ltw.setup({})

return {
	"folke/snacks.nvim",
	opts = {
		dashboard = {
			sections = {
				-- { section = "header", padding = 5 },
				{
					section = "terminal",
					cmd =
					'chafa -p off --speed=1 --clear --passthrough=tmux --scale max "$HOME/.config/nvim/toad_dancing.gif"',
					indent = 12,
					ttl = 0,
					enabled = function()
						return vim.fn.executable("chafa") == 1 and vim.fn.environ()["SSH_CLIENT"] == nil
					end,
					height = 20,
					padding = 1,
				},
				{
					icon = "",
					title = "Little TaskWarrior",
				},
				{
					text = ltw.get_snacks_dashboard_tasks(56, "dir", "special"),
					indent = 2,
				},
				{ section = "startup" },
				{
					pane = 2,
					{
						{
							action = ":ObsidianQuickSwitch",
							key = "o",
							desc = "Open Obsidian Note",
							icon = " ",
							gap = 1,
							padding = 1,
						},
						{ section = "keys", gap = 1, padding = 1 },
						-- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
						{
							section = "recent_files",
							title = "Recents files",
							limit = 8,
						},
					}
				}
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

	-- Combined function to open the floating window and view the file
	view_cat = function()
		require("myPlugin").open_win() -- Open the floating window
		require("myPlugin").view()   -- Load the file content
	end,

}
