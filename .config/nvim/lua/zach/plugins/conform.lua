return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatter_by_ft = {
				java = { "ast-grep" },
				cpp = { "ast-grep", "clang-format" },
				lua = { "stylua" },
				latex = { "latexindent" },
				python = { "isort", "black" },
				markdown = { "cbfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500
			}
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
