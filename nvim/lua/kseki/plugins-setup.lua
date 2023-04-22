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

local packer_bootstrap = ensure_packer() -- true if packer.nvim is not installed

-- Autocomand that reloads neovim whenever your save this file
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
	use("wbthomason/packer.nvim")

	-- lua functions that many plugins use
	use("nvim-lua/plenary.nvim")

	use("EdenEast/nightfox.nvim")

	use("christoomey/vim-tmux-navigator")
	use("szw/vim-maximizer")

	-- Essential plugins
	use({ "tpope/vim-surround", event = "BufRead" })
	use({ "tpope/vim-repeat", after = { "vim-surround" } })
	use("vim-scripts/ReplaceWithRegister")

	-- Commenting with gc
	use({ "numToStr/Comment.nvim", event = "BufRead" })

	-- File explorer
	use("nvim-tree/nvim-tree.lua")

	-- Icon
	use("nvim-tree/nvim-web-devicons")

	-- Statusline
	use("nvim-lualine/lualine.nvim")

	-- Fuzzy finding
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		cmd = "Telescope",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	-- Autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lua")

	use("zbirenbaum/copilot.lua")
	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("kseki.plugins.lsp.copilot-cmp")
		end,
	})

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- Managing & Installing lsp servers
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Configuring lsp servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use("onsails/lspkind.nvim")

	-- Formatting & Linting
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")
	use({
		"folke/trouble.nvim",
		event = "BufRead",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("kseki.plugins.trouble")
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdateSync",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		requires = {
			"windwp/nvim-ts-autotag",
			"RRethy/nvim-treesitter-endwise",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-textsubjects",
		},
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("kseki.plugins.indent-blankline")
		end,
	})

	-- Git signs plugin
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("kseki.plugins.gitsigns")
		end,
	})
	use({
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
	})

	-- Highlighting
	use({
		"t9md/vim-quickhl",
		event = "BufRead",
	})

	-- Open browser
	use({
		"tyru/open-browser-github.vim",
		event = "BufRead",
		requires = "tyru/open-browser.vim",
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		cmd = "MarkdownPreview",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("kseki.plugins.colorizer")
		end,
	})

	use({
		"wakatime/vim-wakatime",
		event = "VimEnter",
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
