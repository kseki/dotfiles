local setup, trouble = pcall(require, "trouble")
if not setup then
	return
end

trouble.setup({
	auto_open = false,
	auto_close = true,
	auto_preview = false,
	auto_fold = false,
	signs = {
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "﫠",
	},
	use_lsp_diagnostic_signs = false,
})

local keymap = vim.keymap
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")
