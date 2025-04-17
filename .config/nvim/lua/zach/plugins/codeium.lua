-- add this to the file where you setup your other plugins:
return {
	"monkoose/neocodeium",
	event = "VeryLazy",
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		vim.
		vim.keymap.set("i", "<A-Tab>", neocodeium.accept)
		vim.keymap.set("i", "<C-Tab>", neocodeium.accept_word)
		vim.keymap.set("i", "<S-Tab>", neocodeium.cycle)
	end,
}
