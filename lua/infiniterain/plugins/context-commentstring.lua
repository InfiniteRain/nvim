require("infiniterain.util").safe_require(
	"ts_context_commentstring",
	"mini.comment",
	function(comment_string, mini_comment)
		comment_string.setup({
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
	end
)
