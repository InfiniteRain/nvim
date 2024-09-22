local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- scrolloff
opt.scrolloff = 10

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
opt.autoread = true
vim.cmd([[
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]])

-- go back into insert mode on lost focus
vim.cmd('autocmd FocusLost * call feedkeys("\\<esc>")')

-- save on focus lost & buf enter
vim.cmd([[
  autocmd FocusLost,BufEnter * nested silent! wall
]])

-- highlight on yank
vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
  augroup END
]])

-- color column
opt.colorcolumn = "80"

-- sort diagnostics by severity (errors will appear first)
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "double" },
})

-- appropriately highlight codefences returned from denols
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}

-- C# tab size
vim.cmd([[autocmd Filetype cs setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
