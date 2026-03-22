if vim.fn.exepath("biome") ~= "" then
	local util = require("kseki2.libs._set_lsp")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	vim.lsp.config("biome", {
		on_attach = util.on_attach,
		capabilities = capabilities,
		cmd = { "biome", "lsp-proxy" },
		on_new_config = function(new_config)
			local pnpm = vim.fs.root(0, { "pnpm-lock.yml", "pnpm-lock.yaml" })
			local cmd = { "npx", "biome", "lsp-proxy" }
			if pnpm then
				cmd = { "pnpm", "biome", "lsp-proxy" }
			end
			new_config.cmd = cmd
		end,
	})
else
	vim.notify("biome is not installed", vim.log.levels.WARN, { title = "biome" })
end
