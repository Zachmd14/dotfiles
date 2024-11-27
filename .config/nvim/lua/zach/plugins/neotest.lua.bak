return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"rcasia/neotest-java"
	},

	config = function()
		require("neotest").setup {
			vim.keymap.set('n', '<leader>mr', ':lua require("neotest").run.run()<CR>')
		}
	end
}
