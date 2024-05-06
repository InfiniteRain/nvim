return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	branch = "0.1.x",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-l>"] = actions.cycle_history_next,
						["<C-h>"] = actions.cycle_history_prev,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				file_ignore_patterns = {
					"node_modules",
					"build/",
					"dist/",
					"yarn.lock",
					".git/",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				oldfiles = {
					cwd_only = true,
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("monorepo")

		local keymap = vim.keymap
		local builtin_config = { path_display = { "truncate" } }

		keymap.set("n", "<leader>ff", function()
			builtin.find_files(builtin_config)
		end)
		keymap.set("n", "<leader>fs", function()
			builtin.live_grep(builtin_config)
		end)
		keymap.set("n", "<leader>fc", function()
			builtin.grep_string(builtin_config)
		end)
		keymap.set("n", "<leader>fr", function()
			builtin.oldfiles(builtin_config)
		end)
		keymap.set("n", "<leader>fd", function()
			builtin.lsp_document_symbols()
		end)
		keymap.set("n", "<leader>fw", function()
			builtin.lsp_workspace_symbols()
		end)
	end,
}
