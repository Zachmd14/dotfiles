return {
	"RutaTang/quicknote.nvim",
	config = function()
		require("quicknote").setup({
			mode = "portable", -- "portable" | "resident", default to "portable"
			sign = "󰎞", -- This is used for the signs on the left side (refer to ShowNoteSigns() api).
			-- You can change it to whatever you want (e.g., some nerd fonts icon), 'N' is default
			filetype = "txt",
			git_branch_recognizable = true, -- If true, quicknote will separate notes by git branch
			-- But it should only be used with resident mode; it has no effect used with portable mode
		})
		-- Keymaps
		vim.keymap.set("n", "<leader>nn", ":lua require('quicknote').NewNoteAtCurrentLine()<CR>", {})
		vim.keymap.set("n", "<leader>ns", ":lua require('quicknote').ShowNoteSigns()<CR>", {})
		vim.keymap.set("n", "<leader>no", ":lua require('quicknote').OpenNoteAtCurrentLine()<CR>", {})
	end,
	dependencies = { "nvim-lua/plenary.nvim" }
}
