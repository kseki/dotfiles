return {
	"anuvyklack/pretty-fold.nvim",
	event = { "BufRead", "BufNewFile" },
	config = function()
		require("pretty-fold").setup()
	end,
}
