return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				csharp = { "csharpier" },
				gdscript = { "gdformat" },
			},
			format_on_save = function()
				local errors = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.ERROR } })

				if #errors > 0 then
					return
				end

				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				}
			end,
		})
	end,
}
