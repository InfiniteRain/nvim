local setup, neo_tree = pcall(require, "neo-tree")
if not setup then
	return
end

neo_tree.setup({
	default_component_configs = {
		indent = {
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
	},
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_hidden = false,
			never_show = {
				".DS_Store",
			},
		},
	},
})

-- color of the title bars that appear on floating windows
vim.cmd("highlight NeoTreeTitleBar guifg=#FFFFFF")
