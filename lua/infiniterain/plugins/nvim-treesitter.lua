local status_treesitter, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_treesitter then
	return
end

local status_context, context = pcall(require, "treesitter-context")
if not status_context then
	return
end

treesitter.setup({
	highlight = {
		enable = true,
	},
	indent = { enable = true },
	autotag = { enable = true },
	ensure_installed = {
		"json",
		"javascript",
		"typescript",
		"tsx",
		"yaml",
		"html",
		"css",
		"markdown",
		"svelte",
		"graphql",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"markdown",
		"markdown_inline",
	},
	auto_install = true,
})

context.setup({})
