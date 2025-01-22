local M = {}

local fmt = string.format
local default_config = require("kseki2.lsp.default")

function M.conf_lsp(name)
	local ok, _ = pcall(require, fmt("lsp.%s", name))

	if not ok then
		default_config(name)
	end
end

function M.on_attach(_, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.formatting()<cr>", bufopts)
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", bufopts)
	vim.keymap.set("n", "ca", "<cmd>Lspsaga code_action<cr>", bufopts)
	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", bufopts)
	vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", bufopts)
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", bufopts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", bufopts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", bufopts)
	vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<cr>", bufopts)

	-- for Diagnostic
	vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<cr>", bufopts)
	vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<cr>", bufopts)
	vim.keymap.set("n", "d[", "<cmd>Lspsaga diagnostic_jump_prev<cr>", bufopts)
	vim.keymap.set("n", "d]", "<cmd>Lspsaga diagnostic_jump_next<cr>", bufopts)
end

return M
