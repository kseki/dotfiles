local function default_config(server)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local util = require("kseki2.libs._set_lsp")

	vim.lsp.config(server, {
		on_attach = util.on_attach,
		capabilities = capabilities,
	})
end

return default_config
