-- https://github.com/nvim-lualine/lualine.nvim
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			disabled_filetypes = {
				statusline = {
					"snacks_explorer",
				},
			},
		})
	end,
}
