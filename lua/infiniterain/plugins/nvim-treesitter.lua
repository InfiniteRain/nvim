return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-context",
	},
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		local context = require("treesitter-context")

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

		context.setup({
			max_lines = 5,
			trim_scope = "inner",
			multiline_threshold = 1,
		})

		vim.cmd("highlight TreesitterContext guibg=#434c5e")
	end,
}
