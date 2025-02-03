return {
	{
		"navarasu/onedark.nvim",
		enabled = false,
		config = function()
			require("onedark").load()
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		config = function()
			vim.cmd("colorscheme nordfox")
		end,
	},
}
