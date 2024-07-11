local setup, hop = pcall(require, "hop")
if not setup then
	return
end

hop.setup({ keys = "etovxqpdygfblzhckisuran" })

local directions = require("hop.hint").HintDirection
local keymap = vim.keymap
local options = { noremap = true, silent = true }

keymap.set("", "f", function()
	hop.hint_char1({
		direction = directions.AFTER_CURSOR,
		current_line_only = true,
	})
end, { remap = true })
keymap.set("", "F", function()
	hop.hint_char1({
		direction = directions.BEFORE_CURSOR,
		current_line_only = true,
	})
end, { remap = true })
keymap.set("", "t", function()
	hop.hint_char1({
		direction = directions.AFTER_CURSOR,
		current_line_only = true,
		hint_offset = -1,
	})
end, { remap = true })
keymap.set("", "T", function()
	hop.hint_char1({
		direction = directions.BEFORE_CURSOR,
		current_line_only = true,
		hint_offset = 1,
	})
end, { remap = true })

keymap.set("n", "ff", "<CMD>HopWord<CR>", options)
keymap.set("n", "//", "<CMD>HopPattern<CR>", options)
