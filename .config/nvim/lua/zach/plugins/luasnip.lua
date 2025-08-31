return {
	'L3MON4D3/LuaSnip',
	config = function()
		local ls = require('luasnip')
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node

		-- Global configuration
		ls.config.set_config({
			history = true,
			updateevents = 'TextChanged,TextChangedI',
			enable_autosnippets = true,
		})

		-- Anki Latex
		ls.add_snippets('anki', {
			s('sub', { t('\\subsection{'), i(1, 'title'), t('}') }),
			s('sec', { t('\\section{'), i(1, 'title'), t('}') }),
			s('page', { t('\\newpage') }),
		})

		-- Auto-snippets
		ls.add_snippets('anki', {
			-- Somme
			s("+++", { t("\\sum_{"), i(1, "first"), t("}^{"), i(2, "max"), t("} "), i(3, "formula") },
				{ snippetType = "autosnippet" }),

			-- Limite
			s("lm", { t("\\lim_{"), i(1, "var"), t(" \\to "), i(2, "+\\infty"), t("}") }, { snippetType = "autosnippet" }),

			-- Parentheses
			s({ trig = 'lrp', regTrig = true, snippetType = 'autosnippet' }, {
				t('\\left('), i(1), t('\\right)')
			}),

			-- Math environment
			s('beg', {
				t('\\begin{'), i(1, 'environment'), t('}'),
				t({ '', '\t' }), i(0),
				t({ '', '\\end{' }), f(function(args) return args[1][1] end, { 1 }), t('}')
			}, { snippetType = 'autosnippet' }),

			-- Display math
			s('dm', {
				t({ '\\[', '\t' }), i(1),
				t({ '', '\\]' })
			}, { snippetType = 'autosnippet' }),

			-- Inline math with smart spacing
			s('mk', {
				t('$'), i(1), t('$'), i(2),
				f(function(_, snip)
					local following = snip.env.TM_NEXT_TEXT or ''
					return not string.match(following, '^[,%.%?%- ]') and ' ' or ''
				end),
			}, { snippetType = 'autosnippet' }),

			-- Fractions
			s({ trig = '//', regTrig = true }, {
				t('\\frac{'), i(1, 'numerator'), t('}{'), i(2, 'denominator'), t('}')
			}, { snippetType = 'autosnippet' }),

			-- Subscript
			s('_', { t('_{'), i(1, 'subscript'), t('}') }, { snippetType = 'autosnippet' }),

			-- Superscript
			s({ trig = '([%w%)%]%}])srr', regTrig = true }, {
				f(function(_, snip) return snip.captures[1] end),
				t('^2')
			}, { snippetType = 'autosnippet' }),

			-- Cube
			s({ trig = '([%w%)%]%}])cb', regTrig = true }, {
				f(function(_, snip) return snip.captures[1] end),
				t('^3')
			}, { snippetType = 'autosnippet' }),

			-- Scientific notation
			s(",,", { t("\\times 10^{"), i(1), t("}") }, { snippetType = 'autosnippet' }),
		}, { type = 'autosnippets' })


		-- =========================================================================
		-- LaTeX Snippets
		-- =========================================================================

		-- Regular snippets
		ls.add_snippets('tex', {
			s('sub', { t('\\subsection{'), i(1, 'title'), t('}') }),
			s('sec', { t('\\section{'), i(1, 'title'), t('}') }),
			s('page', { t('\\newpage') }),
		})

		-- Auto-snippets
		ls.add_snippets('tex', {
			-- Somme
			s("+++", { t("\\sum_{"), i(1, "first"), t("}^{"), i(2, "max"), t("} "), i(3, "formula") },
				{ snippetType = "autosnippet" }),

			-- Limite
			s("lm", { t("\\lim_{"), i(1, "var"), t(" \\to "), i(2, "+\\infty"), t("}") }, { snippetType = "autosnippet" }),

			-- Parentheses
			s({ trig = 'lrp', regTrig = true, snippetType = 'autosnippet' }, {
				t('\\left('), i(1), t('\\right)')
			}),

			-- Math environment
			s('beg', {
				t('\\begin{'), i(1, 'environment'), t('}'),
				t({ '', '\t' }), i(0),
				t({ '', '\\end{' }), f(function(args) return args[1][1] end, { 1 }), t('}')
			}, { snippetType = 'autosnippet' }),

			-- Display math
			s('dm', {
				t({ '\\[', '\t' }), i(1),
				t({ '', '\\]' })
			}, { snippetType = 'autosnippet' }),

			-- Inline math with smart spacing
			s('mk', {
				t('$'), i(1), t('$'), i(2),
				f(function(_, snip)
					local following = snip.env.TM_NEXT_TEXT or ''
					return not string.match(following, '^[,%.%?%- ]') and ' ' or ''
				end),
			}, { snippetType = 'autosnippet' }),

			-- Fractions
			s({ trig = '//', regTrig = true }, {
				t('\\frac{'), i(1, 'numerator'), t('}{'), i(2, 'denominator'), t('}')
			}, { snippetType = 'autosnippet' }),

			-- Subscript
			s('_', { t('_{'), i(1, 'subscript'), t('}') }, { snippetType = 'autosnippet' }),

			-- Superscript
			s({ trig = '([%w%)%]%}])srr', regTrig = true }, {
				f(function(_, snip) return snip.captures[1] end),
				t('^2')
			}, { snippetType = 'autosnippet' }),

			-- Cube
			s({ trig = '([%w%)%]%}])cb', regTrig = true }, {
				f(function(_, snip) return snip.captures[1] end),
				t('^3')
			}, { snippetType = 'autosnippet' }),

			-- Scientific notation
			s(",,", { t("\\times 10^{"), i(1), t("}") }, { snippetType = 'autosnippet' }),
		}, { type = 'autosnippets' })

		-- =========================================================================
		-- Markdown Snippets
		-- =========================================================================

		-- Regular snippets
		ls.add_snippets('markdown', {
			-- code block
			s("code", { t("```"), i(1, "language"), t({ "", "" }), i(2, "code"), t({ "", "" }), t("```") }),
			-- note
			s("note", { t("> [!note]"), t({ "", "" }), t("> "), i(1) }),
			-- texte en gras
			s("bold", { t("**"), i(1), t("**"), i(2) }),
			-- callout important
			s("imp", { t("> [!important]"), t({ "", "" }), t("> "), i(1) }),
			-- callout tip
			s("tip", { t("> [!tip]"), t({ "", "" }), t("> "), i(1) }),
			-- date
			s("date", { f(function() return os.date("%Y-%m-%d") end) }),
			-- Math environment
			s('beg', {
				t('\\begin{'), i(1, 'environment'), t('}'),
				t({ '', '\t' }), i(0),
				t({ '', '\\end{' }), f(function(args) return args[1][1] end, { 1 }), t('}')
			}),
			-- Pour tout
			s({ trig = "fall", regTrig = true, snippetType = "autosnippet" }, {
				t("\\forall "), i(1, "letter"), t(" \\in \\mathbb{"), i(2, "set"), t("}")
			}),
		})

		-- Auto-snippets
		ls.add_snippets('markdown', {
			-- Scientific notation
			s(",,", { t("\\times 10^{"), i(1), t("}") }, { snippetType = 'autosnippet' }),
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
			s("__", { t("_{"), i(1, "number"), t("}") }),
			-- Exposant
			s({ trig = "([A-Za-z%d]+)srr", regTrig = true, snippetType = "autosnippet" }, {
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
			-- code ``
			s("cd", { t("`"), i(1), t("`") }),
		}, { type = "autosnippets" })

		-- Anki cards snippets
		ls.add_snippets('anki', {
			s('clz', { t('{{c1::'), i(1, 'text'), t('}}') }),
		}, { type = 'autosnippets' })


		-- =========================================================================
		-- Keybindings
		-- =========================================================================
		vim.keymap.set({ 'i', 's' }, '<Tab>', function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })

		vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })
	end
}
