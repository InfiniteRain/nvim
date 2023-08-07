require("infiniterain.util").safe_require("gitsigns", function(gitsigns)
	gitsigns.setup({
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		_signs_staged_enable = true,
	})
end)
