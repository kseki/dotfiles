return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufRead", "BufNewFile" },
		dependencies = {
			"RRethy/nvim-treesitter-endwise",
			"RRethy/nvim-treesitter-textsubjects",
		},
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"query",
					"javascript",
					"html",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				endwise = { enable = true },
				textsubjects = {
					enable = true,
					prev_selection = ",", -- (Optional) keymap to select the previous selection
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = {
							"textsubjects-container-inner",
							desc = "Select inside containers (classes, functions, etc.)",
						},
					},
				},
			})
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
