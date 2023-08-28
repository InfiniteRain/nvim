-- install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

-- automatically reload neovim and refresh plugins on file save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- packer
	use("wbthomason/packer.nvim")

	-- dependency for many other lua plugins
	use("nvim-lua/plenary.nvim")

	-- color scheme
	use("gbprod/nord.nvim")

	-- tmux & split window navigation
	use("christoomey/vim-tmux-navigator")

	-- maximizer
	use("szw/vim-maximizer")

	-- vim surround
	use("tpope/vim-surround")

	-- replace with register
	use("vim-scripts/ReplaceWithRegister")

	-- commenting
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-web-devicons")
	use("MunifTanjim/nui.nvim")
	use({ "nvim-neo-tree/neo-tree.nvim", branch = "v3.x" })

	-- status line
	use("nvim-lualine/lualine.nvim")

	-- telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

	-- autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- configuring lsp servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use({ "nvimdev/lspsaga.nvim", branch = "main" })
	use("jose-elias-alvarez/typescript.nvim")
	use("onsails/lspkind.nvim")

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("nvim-treesitter/nvim-treesitter-context")

	-- auto closing
	use("windwp/nvim-autopairs")
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

	-- gitsigns
	use("lewis6991/gitsigns.nvim")

	-- neotest
	use("antoinemadec/FixCursorHold.nvim")
	use("haydenmeade/neotest-jest")
	use("nvim-neotest/neotest")

	-- lazygit
	use("kdheepak/lazygit.nvim")

	-- harpoon
	use("ThePrimeagen/harpoon")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
