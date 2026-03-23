return {
	{ "vim-denops/denops.vim", lazy = false },
	{
		"lambdalisue/kensaku-search.vim",
		dependencies = { "lambdalisue/kensaku.vim" },
		event = "CmdlineEnter",
		config = function()
			vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>")
		end,
	},
	{ "lambdalisue/kensaku.vim", lazy = true },
	{
		"yuki-yano/fuzzy-motion.vim",
		keys = {
			{ "S", "<cmd>FuzzyMotion<CR>", desc = "Fuzzy Motion" },
		},
		config = function()
			vim.cmd("let g:fuzzy_motion_matchers = ['kensaku', 'fzf']")
		end,
	},
}
