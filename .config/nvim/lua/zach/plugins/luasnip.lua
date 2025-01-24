return {
	'L3MON4D3/LuaSnip',
	config = function()
		local ls = require "luasnip"
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node

		-- Snippets LaTeX (non-auto)
		ls.add_snippets("tex", {
			-- sous-section
			s("sub", { t("\\subsection{"), i(1, "title"), t("}") }),

			-- section
			s("sec", { t("\\section{"), i(1, "title"), t("}") }),

			-- nouvelle page
			s("page", { t("\\newpage") }),
		})

		-- Snippets LaTeX (auto)
		ls.add_snippets("tex", {
			-- flèche gauche-droite
			s("rlarrow", { t("\\leftrightarrows") }),

			-- flèche gauche-droite (double)
			s("Lrarrow", { t("\\Leftrightarrow") }),
			-- cube
			s({ trig = "([A-Za-z%d]+)cb", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1]
					return var .. "^3"
				end)
			}),

			-- racine carrée
			s("sqrt", { t("\\sqrt{"), i(0), t("}") }),

			-- texte en gras
			s("bf", { t("\\textbf{"), i(1, "text"), t("}") }),

			-- opérateurs mathématiques
			s("geq", { t("\\geq") }),
			s("leq", { t("\\leq") }),

			-- 10^
			s({ trig = "([A-Za-z%d]+),,", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1]
					return var .. ".10^"
				end),
				i(1, "number")
			}),

			-- environnement
			s("beg", {
				t("\\begin{"), i(1, "environment"), t("}"),
				i(0), t({ "", "\\end{" }), f(function(args) return args[1][1] end, { 1 }), t("}")
			}),

			-- Mathématiques en ligne
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

			-- Mathématiques affichées
			s("dm", {
				t({ "\\[", "" }),
				t("  "), i(1),
				t({ "", "\\]" })
			}),

			-- Somme
			s("+++", { t("\\sum_{"), i(1, "first"), t("}^{"), i(2, "max"), t("}{"), i(3, "formula"), t("}") }),

			-- Limite
			s("lm", { t("\\lim_{"), i(1, "set"), t(" \\to "), i(2, "plus ou moins"), t("\\infty}") }),

			-- Indice
			s("_", { t("_{"), i(1, "number"), t("}") }),

			-- Exposant
			s({ trig = "([A-Za-z%d]+)sr", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1]
					return var .. "^2"
				end)
			}),

			-- Texte
			s("tx", { t("\\text{"), i(1, "text"), t("}") }),

			-- Fraction
			s({ trig = "//", regTrig = true, snippetType = "autosnippet" }, {
				t("\\frac{"), i(1, "numerator"), t("}{"), i(2, "denominator"), t("}")
			}),

			-- Pour tout
			s({ trig = "fall", regTrig = true, snippetType = "autosnippet" }, {
				t("\\forall "), i(1, "letter"), t(" \\in \\mathbb{"), i(2, "set"), t("}")
			}),

		}, { type = "autosnippets", key = "all_auto" })

		-- Snippets Markdown
		ls.add_snippets("markdown", {
			-- texte en gras
			s("bold", { t("**"), i(1), t("**"), i(2) }),

			-- callout important
			s("imp", { t("> [!important]"), t({ "", "" }), t("> "), i(1) }),

			-- callout tip
			s("tip", { t("> [!tip]"), t({ "", "" }), t("> "), i(1) }),

			-- date
			s("date", { f(function() return os.date("%Y-%m-%d") end) }),

			-- boîte
			s("tbox", { t("\\fbox{"), i(1, "text"), t("}") }),

			s("fbox", { t("\\boxed{"), i(1, "formula"), t("}") }),

			-- espace insécable
			s("nbsp", { t("&nbsp;") }),

			-- parenthèses adaptatives
			s({ trig = "lrp", regTrig = true, snippetType = "autosnippet" }, {
				t("\\left("), i(1), t("\\right)")
			}),

			-- flèche gauche-droite
			s("rlarrow", { t("\\leftrightarrows") }),

			-- flèche gauche-droite (double)
			s("Lrarrow", { t("\\Leftrightarrow") }),

			-- Mathématiques en ligne
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

			-- Mathématiques affichées
			s("dm", { t("$$"), i(1), t("$$") }),

			-- Somme
			s("+++", { t("\\sum_{"), i(1, "first"), t("}^{"), i(2, "max"), t("}{"), i(3, "formula"), t("}") }),

			-- Limite
			s("lm", { t("\\lim_{"), i(1, "set"), t(" \\to "), i(2, "plus ou moins"), t("\\infty}") }),

			-- Indice
			s("_", { t("_{"), i(1, "number"), t("}") }),

			-- Exposant
			s({ trig = "([A-Za-z%d]+)sr", regTrig = true, snippetType = "autosnippet" }, {
				f(function(_, snip)
					local var = snip.captures[1]
					return var .. "^2"
				end)
			}),

			-- Texte
			s("tx", { t("\\text{"), i(1, "text"), t("}") }),

			-- Fraction
			s({ trig = "//", regTrig = true, snippetType = "autosnippet" }, {
				t("\\frac{"), i(1, "numerator"), t("}{"), i(2, "denominator"), t("}")
			}),

			-- Pour tout
			s({ trig = "fall", regTrig = true, snippetType = "autosnippet" }, {
				t("\\forall "), i(1, "letter"), t(" \\in \\mathbb{"), i(2, "set"), t("}")
			}),

		})

		-- Configuration de LuaSnip
		ls.config.set_config({
			enable_autosnippets = true,
		})

		-- Mappage des touches
		vim.api.nvim_set_keymap("i", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<Cr>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("i", "<s-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>", { noremap = true, silent = true })
	end
}
