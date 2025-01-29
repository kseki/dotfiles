return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		require("telescope").load_extension("fzf")
	end,
	keys = {
		{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Find file", mode = "n" },
		{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Grep files", mode = "n" },
		{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Find buffer", mode = "n" },
		{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", desc = "Find help", mode = "n" },
		{ "<leader>fs", "<cmd>lua require('telescope.builtin').git_status()<CR>", desc = "Git status", mode = "n" },
	},
}
