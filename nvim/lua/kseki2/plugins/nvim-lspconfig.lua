return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Mason
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
				},
			})

			-- LSP
			local utils = require("kseki2.libs._set_lsp")
			local conf_lsp = utils.conf_lsp

			local servers = {
				"biome",
				"cssls",
				"gopls",
				"jsonls",
				"lua_ls",
				"ruby_lsp",
				"sqlls",
				"tailwindcss",
				"tflint",
				"ts_ls",
				"yamlls",
			}

			for _, lsp in ipairs(servers) do
				conf_lsp(lsp)
			end

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				pattern = "*",
				command = [[ lua vim.diagnostic.open_float(nil, {focus=false}) ]],
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
	},
}
