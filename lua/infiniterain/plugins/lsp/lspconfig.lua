return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.cmd("highlight DiagnosticVirtualTextError guifg=#db4b4b gui=bold,italic,underline")
		vim.cmd("highlight DiagnosticVirtualTextWarning guifg=#e0af68 gui=bold,italic,underline")
		vim.cmd("highlight DiagnosticVirtualTextInformation guifg=#0db9d7 gui=bold,italic,underline")
		vim.cmd("highlight DiagnosticVirtualTextHint guifg=#10B981 gui=bold,italic,underline")

		local keymap = vim.keymap

		local opts = { noremap = true, silent = true }
		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

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
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local border = "double"
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		}

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
		})

		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
			root_dir = lspconfig.util.root_pattern("package.json"),
			single_file_support = false,
		})

		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
		})

		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
		})

		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
			settings = {
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make the language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						allFeatures = true,
						overrideCommand = {
							"cargo",
							"clippy",
							"--workspace",
							"--message-format=json",
							"--all-targets",
							"--all-features",
						},
					},
				},
			},
		})

		lspconfig["denols"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		})

		lspconfig["omnisharp"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp" },
			handlers = {
				["textDocument/definition"] = require("omnisharp_extended").handler,
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			},
			enable_editorconfig_support = true,
			enable_ms_build_load_projects_on_demand = false,
			enable_roslyn_analyzers = true,
			organize_imports_on_format = true,
			enable_import_completion = true,
			sdk_include_prereleases = true,
			analyze_open_documents_only = true,
		})

		lspconfig["gdscript"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
		})

		lspconfig["elmls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
				["window/showMessageRequest"] = function(whatever, result)
					-- For some reason, the showMessageRequest handler doesn't work with
					-- the format failed error. It just hangs on the screen and can't
					-- interact with the vim.ui.select thingy. So skip it.
					if result.message:find("Running elm-format failed", 1, true) then
						print(result.message)
						return vim.NIL
					end
					return vim.lsp.handlers["window/showMessageRequest"](whatever, result)
				end,
			},
		})

		lspconfig["zls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
			settings = {
				enable_autofix = true,
				enable_build_on_save = true,
				build_on_save_step = "check",
				warn_style = true,
			},
		})

		lspconfig["svelte"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
				on_attach(client, bufnr)
			end,
		})

		-- disable the annoying popup each time an error occurs
		vim.g.zig_fmt_parse_errors = 0

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = handlers,
			before_init = function(_, config)
				local Path = require("plenary.path")
				local venv = Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")
				if venv:joinpath("bin"):is_dir() then
					config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
				else
					config.settings.python.pythonPath = tostring(venv:joinpath("Scripts", "python.exe"))
				end
			end,
		})
	end,
}
