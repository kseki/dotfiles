-- での
return {
	{ "vim-denops/denops.vim", lazy = false },
	{
		"lambdalisue/kensaku-search.vim",
		lazy = false,
		config = function()
			vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>")
		end,
	},
	{ "lambdalisue/kensaku.vim", lazy = false },
	{
		"yuki-yano/fuzzy-motion.vim",
		lazy = false,
		config = function()
			vim.keymap.set("n", "S", "<cmd>FuzzyMotion<CR>")
			vim.cmd("let g:fuzzy_motion_matchers = ['kensaku', 'fzf']")
		end,
	},
}
