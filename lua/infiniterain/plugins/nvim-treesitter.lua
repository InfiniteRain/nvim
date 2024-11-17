return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		local context = require("treesitter-context")

		vim.filetype.add({
			extension = {
				rs2 = "runescript",
				cs2 = "clientscript",
			},
		})

		treesitter.setup({
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = { "zig" },
			},
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
				"zig",
			},
			auto_install = true,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-s>",
					node_incremental = "<C-s>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})

		context.setup({
			max_lines = 5,
			trim_scope = "inner",
			multiline_threshold = 1,
		})

		vim.cmd("highlight TreesitterContext guibg=#434c5e")
	end,
}
