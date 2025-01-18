local commit_staged_prompt = [[
以下の条件を踏まえて変更に対するコミットメッセージを書いてください。

- コミットメッセージのprefixは、commitizenの規約に従ってください。
- コミットメッセージ本文は日本語で書いてください。
- タイトルは最大50文字、変更理由を含めてください。
- メッセージは72文字で折り返してください。
- メッセージ全体をgitcommit言語のコードブロックで囲んでください。
- ソースを見ても変更した理由がわからない時は、コミットメッセージを作る前に質問して、その回答も参考にコミットメッセージを生成してください。
]]

local function generate_prompts(select)
	return {
		Explain = {
			prompt = "/COPILOT_EXPLAIN\n\nアクティブな選択範囲の説明を段落形式で書いてください。日本語で返答ください。",
		},
		Review = {
			prompt = "/COPILOT_REVIEW\n\n選択されたコードをレビューしてください。日本語で返答ください。",
		},
		FixCode = {
			prompt = "/COPILOT_GENERATE\n\nこのコードには問題があります。バグを修正したコードに書き直してください。日本語で返答ください。",
		},
		Refactor = {
			prompt = "/COPILOT_GENERATE\n\n明瞭性と可読性を向上させるために、次のコードをリファクタリングしてください。日本語で返答ください。",
		},
		BetterNamings = {
			prompt = "/COPILOT_GENERATE\n\n選択されたコードの変数名や関数名を改善してください。日本語で返答ください。",
		},
		Documentation = {
			prompt = "/COPILOT_GENERATE\n\n選択範囲にドキュメントコメントを追加してください。日本語で返答ください。",
		},
		Tests = {
			prompt = "/COPILOT_GENERATE\n\nコードのテストを生成してください。日本語で返答ください。",
		},
		Wording = {
			prompt = "/COPILOT_GENERATE\n\n次のテキストの文法と表現を改善してください。日本語で返答ください。",
		},
		Summarize = {
			prompt = "/COPILOT_GENERATE\n\n選択範囲の要約を書いてください。日本語で返答ください。",
		},
		Spelling = {
			prompt = "/COPILOT_GENERATE\n\n次のテキストのスペルミスを修正してください。日本語で返答ください。",
		},
		FixDiagnostic = {
			prompt = "ファイル内の次の問題を支援してください:",
			selection = select.diagnostics,
		},
		CommitStaged = {
			prompt = "#git:staged\n\n" .. commit_staged_prompt,
			callback = function(response, _)
				local commit_message = response:match("```gitcommit\n(.-)```")
				if commit_message then
					vim.fn.setreg("+", commit_message, "c")
				end
			end,
		},
	}
end

return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "BufRead",
		dependencies = {
			{ "zbirenbaum/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = function()
			local select = require("CopilotChat.select")
			return {
				auto_insert_mode = true,
				question_header = "  User ",
				answer_header = "  Copilot ",
				prompts = generate_prompts(select),
			}
		end,
		keys = {
			{
				"<leader>cp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
			{ "<leader>cl", "<cmd>CopilotChatReset<CR>", desc = "CopilotChat - Clear buffer and chat history" },
			{ "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "CopilotChat - Toggle Vsplit" },
		},
	},
}
