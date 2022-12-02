local setup, nvim_tree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvim_tree.setup({
	-- change folder arrow icons
	renderer = {
		icons = {
			glyphs = {
				folder = {
					-- arrow when folder is closed
					arrow_closed = "",
					-- arrow when folder is open
					arrow_open = "",
				},
			},
		},
	},

	-- disable window_picker for explorer to work well
	-- with window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
