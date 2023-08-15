require("infiniterain.util").safe_require("nvim-treesitter.configs", "treesitter-context", function(treesitter, context)
	treesitter.setup({
		highlight = {
			enable = true,
		},
		indent = { enable = true },
		autotag = { enable = true },
		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"markdown",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"markdown",
			"markdown_inline",
		},
		auto_install = true,
	})

	context.setup({})

	vim.cmd("highlight TreesitterContext guibg=#434c5e")
end)
