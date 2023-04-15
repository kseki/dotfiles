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
	use("numToStr/Comment.nvim")

	-- File explorer
	use("nvim-tree/nvim-tree.lua")

	-- Icon
	use("nvim-tree/nvim-web-devicons")

	-- Statusline
	use("nvim-lualine/lualine.nvim")

	-- Fuzzy finding
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.1" })

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
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("kseki.plugins.indent-blankline")
		end,
	})

	-- Auto closing
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use("RRethy/nvim-treesitter-endwise")

	-- Git signs plugin
	use("lewis6991/gitsigns.nvim")

	-- Highlighting
	use({
		"t9md/vim-quickhl",
		event = "BufRead",
		config = function()
			vim.keymap.set("n", "<Space>m", "<Plug>(quickhl-manual-this)", { noremap = false })
			vim.keymap.set("x", "<Space>m", "<Plug>(quickhl-manual-this)", { noremap = false })
			vim.keymap.set("n", "<Space>M", "<Plug>(quickhl-manual-reset)", { noremap = false })
			vim.keymap.set("x", "<Space>M", "<Plug>(quickhl-manual-reset)", { noremap = false })
		end,
	})

	-- Open browser
	use({
		"tyru/open-browser-github.vim",
		event = "BufRead",
		requires = "tyru/open-browser.vim",
		config = function()
			vim.keymap.set("n", "<Leader>o", "<Plug>(openbrowser-open)")
			vim.keymap.set("v", "<Leader>os", "<Plug>(openbrowser-smart-search)")
		end,
	})

	use({
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			vim.keymap.set("n", "<Leader>op", "<cmd>MarkdownPreview<CR>")
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
