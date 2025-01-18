if vim.fn.exepath("lsp_name") ~= "" then
	local lspconfig = require("lspconfig")
	local util = require("kseki2.libs._set_lsp")

	lspconfig.template.setup({
		on_attach = util.on_attach,
		capabilities = util.capabilities,
		flags = util.flags,
		cmd = { "biome", "lsp-proxy" },
		on_new_config = function(new_config)
			local pnpm = lspconfig.util.root_pattern("pnpm-lock.yml", "pnpm-lock.yaml")(vim.api.nvim_buf_get_name(0))
			local cmd = { "npx", "biome", "lsp-proxy" }
			if pnpm then
				cmd = { "pnpm", "biome", "lsp-proxy" }
			end
			new_config.cmd = cmd
		end,
	})
else
	vim.notify("lsp install command", vim.log.levels.WARN, { title = "biome" })
end
