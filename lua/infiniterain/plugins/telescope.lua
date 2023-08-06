require("infiniterain.core.util").safe_require("telescope", "telescope.actions", function(telescope, actions)
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
				"build",
				"dist",
				"yarn.lock",
				".git/",
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
		},
	})

	telescope.load_extension("fzf")
end)
