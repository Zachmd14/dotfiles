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
				{ pane = 2, section = "terminal", cmd = "cat ~/Documents/Obsidian/mainVault/TODO.TXT", hl = "header", padding = 1, indent = 4 },
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
}
