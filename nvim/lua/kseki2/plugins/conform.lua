return {
	"stevearc/conform.nvim",
	evnet = "BufferEnter",
	config = function()
		local js_formatters = { { "biome" } }

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = js_formatters,
				javascriptreact = js_formatters,
				typescript = js_formatters,
				typescriptreact = js_formatters,
			},
			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true,
				quiet = false,
			},
		})
	end,
}
