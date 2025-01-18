local function default_config(server)
  local lspconfig = require('lspconfig')
  local util = require('kseki2.libs._set_lsp')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig[server].setup {
    on_attach = util.on_attach,
    capabilities = capabilities,
    flags = util.flags,
  }
end

return default_config
