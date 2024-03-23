return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	config = function()
		local dressing = require("dressing")

		dressing.setup({
			input = {
				insert_only = false,
				start_in_insert = false,
				border = "double",
			},
		})
	end,
}
