return {
	'nvim-telescope/telescope.nvim', branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<CR>" },
		{ "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<CR>" },
		{ "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<CR>" },
		{ "<leader>h", "<cmd>lua require('telescope.builtin').help_tags()<CR>" },
	}
}
