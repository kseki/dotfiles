local copilot_status, copilot = pcall(require, "copilot")
if not copilot_status then
	return
end

local copilot_cmp_status, copilot_cmp = pcall(require, "copilot_cmp")
if not copilot_cmp_status then
	return
end

copilot.setup({
	-- 現在cmpでは複数行を表示できないのでコメントアウト
	suggestion = { enabled = false },
	panel = { enabled = false },
	--suggestion = {
	--	enabled = true,
	--	auto_trigger = true,
	--	keymap = {
	--		accept = "<leader>k",
	--		accept_word = false,
	--		accept_line = false,
	--		next = "<M-n>",
	--		prev = "<M-p>",
	--		dismiss = "<M-e>",
	--	},
	--},
})

copilot_cmp.setup({
	event = { "InsertEnter", "LspAttach" },
	fix_pairs = true,
})
