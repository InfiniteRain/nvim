require("infiniterain.core.util").safe_require("null-ls", function(null_ls)
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	-- to setup format on save
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	null_ls.setup({
		sources = {
			formatting.prettier,
			formatting.stylua,
			diagnostics.eslint_d.with({
				-- only enable eslint if root has .eslintrc.js
				condition = function(utils)
					return utils.root_has_file(".eslintrc.js")
				end,
			}),
			formatting.rustfmt.with({
				extra_args = function(params)
					local Path = require("plenary.path")
					local cargo_toml = Path:new(params.root .. "/Cargo.toml")

					if cargo_toml:exists() and cargo_toml:is_file() then
						for _, line in ipairs(cargo_toml:readlines()) do
							local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])

							if edition then
								return { "--edition=" .. edition }
							end
						end
					end

					-- default edition when we don't find `Cargo.toml` or the `edition` in it.
					return { "--edition=2021" }
				end,
			}),
		},

		-- configure format on save
		on_attach = function(current_client, bufnr)
			if current_client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							filter = function(client)
								--  only use null-ls for formatting instead of lsp server
								return client.name == "null-ls"
							end,
							bufnr = bufnr,
						})
					end,
				})
			end
		end,
	})
end)
