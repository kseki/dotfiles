return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Find file", mode = "n" },
		{ "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Grep files", mode = "n" },
		{ "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Find buffer", mode = "n" },
		{ "<leader>h", "<cmd>lua require('telescope.builtin').help_tags()<CR>", desc = "Find help", mode = "n" },
	},
}
