return
{
	"rareitems/anki.nvim",
	-- Don't lazy load, as per the comment, since it tries to be lazy itself
	opts = {
		{
			tex_support = false, -- Disable LaTeX support (set to `true` if you want LaTeX support)
			models = {
				-- Map your Anki note types (models) to specific decks

				["Basic"] = "Basic",             -- Maps "Basic" note type to "Default" deck
				["Super Basic"] = "MyDeck::SubDeck", -- Maps "Super Basic" note type to "MyDeck::SubDeck"
			},
		}
	}
}
