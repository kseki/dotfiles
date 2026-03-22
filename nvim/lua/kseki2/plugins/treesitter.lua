return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufRead", "BufNewFile" },
		dependencies = {
			"RRethy/nvim-treesitter-endwise",
		},
		config = function()
			require("nvim-treesitter").setup({})
		end,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			"<space>m",
			"<space>j",
			"<space>s",
		},
		config = function()
			require("treesj").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
