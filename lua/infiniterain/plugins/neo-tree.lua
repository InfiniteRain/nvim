require("infiniterain.util").safe_require("neo-tree", function(neo_tree)
	local execute_win_command = require("infiniterain.util").execute_win_command

	neo_tree.setup({
		event_handlers = {
			{
				event = "neo_tree_window_after_open",
				handler = function(state)
					execute_win_command(state.winid, "setlocal scrolloff=10000")
				end,
			},
		},
		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		default_component_configs = {
			indent = {
				with_expanders = true,
				expander_highlight = "NeoTreeExpander",
			},
		},
		filesystem = {
			bind_to_cwd = true,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
				never_show = {
					".DS_Store",
				},
			},
			window = {
				position = "float",
				mappings = {
					["z"] = "none",
				},
				fuzzy_finder_mappings = {
					["<C-j>"] = "move_cursor_down",
					["<C-k>"] = "move_cursor_up",
				},
			},
		},
	})

	-- color of the title bars that appear on floating windows
	vim.cmd("highlight NeoTreeTitleBar guifg=#FFFFFF")
end)
