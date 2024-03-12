return {
	"imNel/monorepo.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		local monorepo = require("monorepo")

		monorepo.setup({
			autoload_telescope = false,
		})
	end,
}
