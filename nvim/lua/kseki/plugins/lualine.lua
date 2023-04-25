local lualine_setup, lualine = pcall(require, "lualine")
if not lualine_setup then
	return
end

local tabline_setup, tabline = pcall(require, "tabline")
if not tabline_setup then
	return
end

tabline.setup({
  enable = false,
  options = {
    show_filename_only = true
  },
})

lualine.setup({
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { require("tabline").tabline_buffers },
		lualine_x = { require("tabline").tabline_tabs },
		lualine_y = {},
		lualine_z = {},
	},
})
