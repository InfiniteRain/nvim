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

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
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

		keymap.set(
			"n",
			"<leader>ff",
			":lua require('telescope.builtin').find_files({ path_display = { 'truncate' } })<cr>"
		)
		keymap.set(
			"n",
			"<leader>fs",
			":lua require('telescope.builtin').live_grep({ path_display = { 'truncate' } })<cr>"
		)
		keymap.set(
			"n",
			"<leader>fc",
			":lua require('telescope.builtin').grep_string({ path_display = { 'truncate' } })<cr>"
		)
		keymap.set(
			"n",
			"<leader>fr",
			":lua require('telescope.builtin').oldfiles({ path_display = { 'truncate' } })<cr>"
		)
	end,
}
