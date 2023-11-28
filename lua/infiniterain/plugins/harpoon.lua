require("infiniterain.util").safe_require("harpoon", function(harpoon)
	harpoon.setup({
		menu = {
			width = vim.api.nvim_win_get_width(0) - 24,
		},
	})
end)
