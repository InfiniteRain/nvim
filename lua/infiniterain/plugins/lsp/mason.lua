return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-null-ls.nvim",
		"jose-elias-alvarez/null-ls.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_null_ls = require("mason-null-ls")

		mason.setup()

		mason_lspconfig.setup({
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"emmet_ls",
				"rust_analyzer",
				"denols",
				"omnisharp",
				"zls",
			},
		})

		mason_null_ls.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"eslint_d",
				"rustfmt",
				"csharpier",
				"gdtoolkit",
				"zigfmt",
			},
		})
	end,
}
