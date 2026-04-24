return {
	"neovim/nvim-lspconfig",
	opts = {
		lua_ls = { enabled = false },
	},
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.cmd("highlight DiagnosticVirtualTextError guifg=#db4b4b gui=bold,italic,underline")
		vim.cmd("highlight DiagnosticVirtualTextWarning guifg=#e0af68 gui=bold,italic,underline")
		vim.cmd("highlight DiagnosticVirtualTextInformation guifg=#0db9d7 gui=bold,italic,underline")
		vim.cmd("highlight DiagnosticVirtualTextHint guifg=#10B981 gui=bold,italic,underline")

		local keymap = vim.keymap
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gu", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Fix all code action"
				keymap.set({ "n", "v" }, "<leader>cf", function()
					vim.lsp.buf.code_action({
						context = {
							only = { "source.fixAll" },
							diagnostics = {},
						},
						apply = true,
					})
					vim.lsp.buf.code_action({
						context = {
							only = { "source.organizeImports" },
							diagnostics = {},
						},
						apply = true,
					})
				end, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Go to previous error"
				keymap.set("n", "[e", function()
					vim.diagnostic.goto_prev({
						severity = vim.diagnostic.severity.ERROR,
					})
				end, opts)

				opts.desc = "Go to next error"
				keymap.set("n", "]e", function()
					vim.diagnostic.goto_next({
						severity = vim.diagnostic.severity.ERROR,
					})
				end, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		vim.lsp.enable({ "html" })

		vim.lsp.enable({ "ts_ls" })

		vim.lsp.enable({ "cssls" })

		vim.lsp.enable({ "tailwindcss" })

		vim.lsp.enable({ "emmet_ls" })

		vim.lsp.enable({ "rust_analyzer" })

		vim.lsp.config("zls", {
			settings = {
				zls = {
					warn_style = true,
					enable_argument_placeholders = false,
				},
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				if vim.bo.ft == "zig" then
					vim.lsp.buf.code_action({
						context = { only = { "source.fixAll" } },
						apply = true,
					})
				end
			end,
		})

		-- disable the annoying popup each time an error occurs
		vim.g.zig_fmt_parse_errors = 0
		-- disable fmt on save
		vim.g.zig_fmt_autosave = 0

		vim.lsp.config("emmylua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
}
