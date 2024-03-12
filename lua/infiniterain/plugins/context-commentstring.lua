return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	dependencies = { "echasnovski/mini.comment" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local ts_context_commentstring = require("ts_context_commentstring")
		local mini_comment = require("mini.comment")

		ts_context_commentstring.setup({
			enable_autocmd = false,
		})

		mini_comment.setup({
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		})
	end,
}
