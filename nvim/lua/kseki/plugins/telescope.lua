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
})

telescope.load_extension("fzf")
