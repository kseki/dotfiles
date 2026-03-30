if vim.fn.exepath("lsp_name") ~= "" then
	local util = require("kseki2.libs._set_lsp")
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	vim.lsp.config("template", {
		on_attach = util.on_attach,
		capabilities = capabilities,
	})
else
	vim.notify("lsp install command", vim.log.levels.WARN, { title = "servername" })
end
