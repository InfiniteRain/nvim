require("infiniterain.util").safe_require("cmp", "luasnip", "lspkind", function(cmp, luasnip, lspkind)
	-- load friendly-snippets
	require("luasnip/loaders/from_vscode").lazy_load()

	vim.opt.completeopt = "menu,menuone,noselect"

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),

		-- snippet sources
		sources = cmp.config.sources({
			-- lsp
			{ name = "nvim_lsp" },

			-- luasnip snippets
			{ name = "luasnip" },

			-- text within current buffer
			{ name = "buffer" },

			-- file system paths
			{ name = "path" },
		}),

		formatting = {
			format = lspkind.cmp_format({
				maxwidth = 50,
				ellipsis_char = "…",
			}),
		},
	})
end)
