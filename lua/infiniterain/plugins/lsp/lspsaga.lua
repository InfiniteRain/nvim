require("infiniterain.core.util").safe_require("lspsaga", function(lspsaga)
	lspsaga.setup({
		move_in_saga = { prev = "<C-k>", next = "<C-j>" },
		finder_action_keys = {
			open = "<CR>",
		},
		definition_action_keys = {
			edit = "<CR>",
		},
	})
end)
