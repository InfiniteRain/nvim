require("infiniterain.core.util").safe_require(
	"mason",
	"mason-lspconfig",
	"mason-null-ls",
	function(mason, mason_lspconfig, mason_null_ls)
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
			},
		})

		mason_null_ls.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"eslint_d",
				"rustfmt",
			},
		})
	end
)
