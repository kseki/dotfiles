-- https://github.com/nvim-neo-tree/neo-tree.nvim 
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_by_name = {
					"node_modules",
					".git"
				},
			},
		},
	},
	keys = { 
		{"<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree toggle" },
        {"<leader>er", "<cmd>Neotree reveal<cr>", desc = "NeoTree reveal" },
	}
}
