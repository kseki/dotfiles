vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("kseki.plugins-setup")
require("kseki.core.options")
require("kseki.core.keymaps")
require("kseki.core.colorscheme")
require("kseki.core.autocmds")
require("kseki.plugins.autopairs")
require("kseki.plugins.comment")
require("kseki.plugins.nvim-tree")
require("kseki.plugins.lualine")
require("kseki.plugins.nvim-cmp")
require("kseki.plugins.lsp.mason")
require("kseki.plugins.lsp.lspsaga")
require("kseki.plugins.lsp.lspconfig")
require("kseki.plugins.lsp.null-ls")
require("kseki.plugins.treesitter")
