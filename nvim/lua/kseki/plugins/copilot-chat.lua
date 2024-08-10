local setup, copilot_chat = pcall(require, "CopilotChat")
if not setup then
	return
end

copilot_chat.setup({
	debug = true,
	show_help = "yes",
	language = "Japanese",
	prompts = {
		Explain = {
			prompt = "/COPILOT_EXPLAIN 上記のコードを日本語で説明してください",
		},
		Tests = {
			prompt = "/COPILOT_TESTS 上記のコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
		},
		Fix = {
			prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
		},
		Optimize = {
			prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
		},
		Docs = {
			prompt = "/COPILOT_REFACTOR 選択したコードのドキュメントを書いてください。返事は、ドキュメントをコメントとして追加した元のコードを含むコードブロックでなければなりません。使用するプログラミング言語（JavaScriptのJSDoc、Pythonのdocstringsなど）に最も適したドキュメントスタイルを使用してください。",
		},
		FixDiagnostic = {
			prompt = "Please assist with the following diagnostic issue in file:",
		},
	},
})

local keymap = vim.keymap
local options = { nowait = true, silent = true }

local telescope = require("CopilotChat.integrations.telescope")
local actions = require("CopilotChat.actions")

keymap.set("n", "<Leader>hh", function()
	telescope.pick(actions.help_actions())
end, options)

keymap.set("n", "<Leader>pp", function()
	telescope.pick(actions.prompt_actions())
end, options)
-- keymap.set("n", "<Leader>ccp", function()
-- 	require("CopilotChat.code_actions").show_prompt_actions()
-- end, { noremap = true, silent = true })
--
-- keymap.set("x", "<Leader>ccp", function()
-- 	require("CopilotChat.code_actions").show_prompt_actions(true)
-- end, { noremap = true, silent = true })
