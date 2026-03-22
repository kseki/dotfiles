-- https://github.com/3rd/image.nvim
return {
	"3rd/image.nvim",
	ft = { "markdown", "norg" },
	opts = {
		backend = "kitty",
		integrations = {
			markdown = {
				enabled = true,
				clear_in_insert_mode = true,
				only_render_image_at_cursor = true,
			},
		},
		max_width = 100,
		max_height = 30,
		tmux_show_only_in_active_window = true,
	},
}
