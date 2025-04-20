return {
	"praczet/little-taskwarrior.nvim",
	config = function()
		require("little-taskwarrior").setup({
			dashboard = {
				limit = 5
			}
		})
	end,
}
