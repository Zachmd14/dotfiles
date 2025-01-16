return {
	'L3MON4D3/LuaSnip',
	config = function()
		local ls = require "luasnip"
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node

		-- Define snippets for LaTeX
		ls.add_snippets("tex", {
			-- cube
			s({ trig = "([A-Za-z%d]+)cb", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1] -- Capture the letter or number before 'sr'
					return var .. "^3"      -- Format as 'a^2' or '3^2'
				end)
			}),

			-- square root
			s("sqrt", {
				t("\\sqrt")
			}),

			-- subsection
			s("sub", {
				t("\\subsection{"), i(1, "title"), t("}")
			}),

			-- sectioon
			s("sec", {
				t("\\section{"), i(1, "title"), t("}")
			}),

			-- bold text
			s("bf", {
				t("\\textbf{"), i(1, "text"), t("}")
			}),

			-- greater than or equal to
			s("geq", {
				t("\\geq")
			}),

			-- less than or equal to
			s("leq", {
				t("\\leq")
			}),

			-- .10^
			s({ trig = "([A-Za-z%d]+),,", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1] -- Capture the letter or number before 'sr'
					return var .. ".10^"    -- Format as 'a^2' or '3^2'
				end),
				i(1, "number")
			}),

			-- New page
			s("page", {
				t("\\newpage")
			}),

			-- Begin and End Environment
			s("beg", {
				t("\\begin{"), i(1, "environment"), t({ "}", "\t" }),
				i(0),
				t({ "", "\\end{" }), f(function(args) return args[1][1] end, { 1 }), t("}"),
			}),

			-- Inline Math
			s("mk", {
				t("$"), i(1), t("$"), i(2),
				f(function(_, snip)
					local following = snip.env.TM_NEXT_TEXT or ""
					if not string.match(following, "^[,%.%?%- ]") then
						return " "
					else
						return ""
					end
				end, {}),
				i(0),
			}),

			-- Display Math
			s("dm", {
				t("\\["),
				t({ "", "\t" }), i(1), t({ "", "\\]" }),
				t({ "", "\t" }), i(2),
			}),

			-- Summation
			s("+++", {
				t("\\sum_{"), i(1, "first"), t("}^{"), i(2, "max"), t("}{"), i(3, "formula"), t("}")
			}),

			-- Limit
			s("lm", {
				t("\\lim_{"), i(1, "set"), t(" \\to "), i(2, "plus or less"), t("\\infty}")
			}),

			-- Subscript
			s("_", {
				i(1, "letter"), t("_{"), i(2, "number"), t("}"), i(3)
			}),

			-- Superscript (Autosnippet)
			s({ trig = "([A-Za-z%d]+)sr", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1] -- Capture the letter or number before 'sr'
					return var .. "^2"      -- Format as 'a^2' or '3^2'
				end)
			}),

			-- Text
			s("tx", {
				t("\\text{"), i(1, "text"), t("}")
			}),

			-- Fraction
			s({ trig = "//", regTrig = true, snippetType = "autosnippet" }, {
				t("\\frac{"), i(1, "numerator"), t("}{"), i(2, "denominator"), t("}")
			}),

			-- For All
			s({ trig = "fall", regTrig = true, snippetType = "autosnippet" }, {
				t("\\forall "), i(1, "letter"), t(" \\in \\mathbb{"), i(2, "set"), t("}")
			}),

		}, { type = "autosnippets", key = "all_auto" })

		-- Define snippets for Markdown
		ls.add_snippets("markdown", {
			-- Begin and End Environment
			s("beg", {
				t("\\begin{"), i(1, "environment"), t({ "}", "\t" }),
				i(0),
				t({ "", "\\end{" }), f(function(args) return args[1][1] end, { 1 }), t("}"),
			}),

			-- bold text
			s("bold", {
				t("**"), i(1), t("**"), i(2)
			}),

			-- important callout
			s("imp", {
				t("> [!important]"),
				t({ "", "" }),
				t("> "), i(1)
			}),

			-- tip callout
			s("tip", {
				t("> [!tip]"),
				t({ "", "" }),
				t("> "), i(1)
			}),

			-- Date
			s("date", {
				f(function()
					return os.date("%Y-%m-%d") -- Formats the date as YYYY-MM-DD
				end),
			}),

			-- Box
			s("tbox", {
				t("\\fbox{"), i(1, "text"), t("}"),
			}),

			s("fbox", {
				t("\\boxed{"), i(1, "formula"), t("}"),
			})

		})

		ls.add_snippets("markdown", {
			-- cube
			s({ trig = "([A-Za-z%d]+)cb", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1] -- Capture the letter or number before 'sr'
					return var .. "^3"      -- Format as 'a^2' or '3^2'
				end)
			}),

			-- square root
			s("sqrt", {
				t("\\sqrt")
			}),

			-- adaptive parenthesis
			s({ trig = "lrp", regTrig = true, snippetType = "autosnippet" }, {
				t("\\left("), i(1), t("\\right)")
			}),

			-- left / right arrow
			s("rlarrow", {
				t("\\leftrightarrows")
			}),

			-- left right arrow
			s("Lrarrow", {
				t("\\Leftrightarrow")
			}),

			-- Inline Math
			s("mk", {
				t("$"), i(1), t("$"), i(2),
				f(function(_, snip)
					local following = snip.env.TM_NEXT_TEXT or ""
					if not string.match(following, "^[,%.%?%- ]") then
						return " "
					else
						return ""
					end
				end, {}),
				i(0),
			}),

			-- Display Math
			s("dm", {
				t("$$"),
				t({ "", "\t" }), i(1), t({ "", "$$" }),
				t({ "", "\t" }), i(2),
			}),

			-- Summation
			s("+++", {
				t("\\sum_{"), i(1, "first"), t("}^{"), i(2, "max"), t("}{"), i(3, "formula"), t("}")
			}),

			-- Limit
			s("lm", {
				t("\\lim_{"), i(1, "set"), t(" \\to "), i(2, "plus or less"), t("\\infty}")
			}),

			-- Subscript
			s("_", {
				t("_{"), i(1, "number"), t("}"),
			}),

			-- Superscript (Autosnippet)
			s({ trig = "([A-Za-z%d]+)sr", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1] -- Capture the letter or number before 'sr'
					return var .. "^2"      -- Format as 'a^2' or '3^2'
				end)
			}),

			-- Text
			s("tx", {
				t("\\text{"), i(1, "text"), t("}")
			}),

			-- Fraction
			s({ trig = "//", regTrig = true, snippetType = "autosnippet" }, {
				t("\\frac{"), i(1, "numerator"), t("}{"), i(2, "denominator"), t("}")
			}),

			-- For All
			s({ trig = "fall", regTrig = true, snippetType = "autosnippet" }, {
				t("\\forall "), i(1, "letter"), t(" \\in \\mathbb{"), i(2, "set"), t("}")
			}),

			-- greater than or equal to
			s("geq", {
				t("\\geq")
			}),

			-- less than or equal to
			s("leq", {
				t("\\leq")
			}),

			-- .10^
			s({ trig = "([A-Za-z%d]+),,", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1] -- Capture the letter or number before 'sr'
					return var .. ".10^"    -- Format as 'a^2' or '3^2'
				end),
				i(1, "number")
			}),

		}, { type = "autosnippets", key = "all_auto" })

		-- Enable autosnippets in your configuration
		ls.config.set_config({
			enable_autosnippets = true,
		})

		-- Key mappings for jumping between snippets
		vim.api.nvim_set_keymap("i", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<Cr>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("i", "<s-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>", { noremap = true, silent = true })
	end
}
