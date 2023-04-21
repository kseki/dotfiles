local telescop_setup, telescope = pcall(require, "telescope")
if not telescop_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

telescope.setup({
	defualts = {
		color_devicons = true,
		mappings = {
			i = {
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<esc>"] = actions.close,
			},
			n = {
				["<esc>"] = actions.close,
			},
			file_ignore_patterns = {
				".git",
				"node_modules",
				"vendor/bundle",
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case",
		},
	},
})

telescope.load_extension("fzf")
