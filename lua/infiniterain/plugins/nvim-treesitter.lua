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
		local treesitter = require("nvim-treesitter")
		local context = require("treesitter-context")

		vim.filetype.add({
			extension = {
				rs2 = "runescript",
				cs2 = "clientscript",
			},
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyDone",
			once = true,
			callback = function()
				treesitter.install({
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
				}, { max_jobs = 8 })
			end,
		})

		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		context.setup({
			max_lines = 5,
			trim_scope = "inner",
			multiline_threshold = 1,
		})

		vim.cmd("highlight TreesitterContext guibg=#434c5e")
	end,
}
