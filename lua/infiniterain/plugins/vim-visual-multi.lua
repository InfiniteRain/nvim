return {
	"mg979/vim-visual-multi",
	config = function()
		vim.cmd("hi! VM_Mono guibg=Grey60 guifg=Black gui=NONE")
		vim.cmd("let g:VM_show_warnings = 0")

		vim.keymap.set("n", "<M-k>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>")
		vim.keymap.set("n", "˚", ":call vm#commands#add_cursor_up(0, v:count1)<cr>")
		vim.keymap.set("n", "<M-j>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>")
		vim.keymap.set("n", "∆", ":call vm#commands#add_cursor_down(0, v:count1)<cr>")
	end,
}
