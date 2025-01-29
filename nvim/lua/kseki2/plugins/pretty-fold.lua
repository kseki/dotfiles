return {
	"anuvyklack/pretty-fold.nvim",
	enabled = false,
	event = { "BufRead", "BufNewFile" },
	config = function()
		require("pretty-fold").setup()
	end,
}
