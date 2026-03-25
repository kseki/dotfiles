return {
	"coder/claudecode.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	keys = {
		{
			"<leader>cc",
			"<cmd>ClaudeCode<cr>",
			desc = "ClaudeCode - Toggle",
		},
		{
			"<leader>cra",
			"<cmd>ClaudeCodeAsk<cr>",
			mode = "v",
			desc = "ClaudeCode - Ask",
		},
		{
			"<leader>cr",
			"<cmd>ClaudeCodeRefactor<cr>",
			mode = "v",
			desc = "ClaudeCode - Refactor",
		},
	},
	opts = {
		terminal = {
			provider = "snacks",
		},
	},
}
