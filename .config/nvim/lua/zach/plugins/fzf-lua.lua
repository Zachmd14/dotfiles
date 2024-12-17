return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		local keymap = vim.keymap
		require("fzf-lua").setup({})
		keymap.set("n", "<leader>ff", ":FzfLua files<CR>")
		keymap.set("n", "<leader>fg", ":FzfLua live_grep<CR>")
		keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>")
	end
}
