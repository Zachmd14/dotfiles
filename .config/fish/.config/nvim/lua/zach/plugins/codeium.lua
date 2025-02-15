-- add this to the file where you setup your other plugins:
return {
	"monkoose/neocodeium",
	event = "VeryLazy",
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		vim.keymap.set("i", "<A-CR>", neocodeium.accept)
		vim.keymap.set("i", "<S-CR>", neocodeium.accept_word)
		vim.keymap.set("i", "<A-Tab>", neocodeium.cycle)
	end,
}
