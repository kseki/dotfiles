local function generate_prompts(select)
  return {
    Explain = {
      prompt = "/COPILOT_EXPLAIN アクティブな選択範囲の説明を段落形式で書いてください。日本語で返答ください。",
    },
    Review = {
      prompt = "/COPILOT_REVIEW 選択されたコードをレビューしてください。日本語で返答ください。",
    },
    FixCode = {
      prompt = "/COPILOT_GENERATE このコードには問題があります。バグを修正したコードに書き直してください。日本語で返答ください。",
    },
    Refactor = {
      prompt = "/COPILOT_GENERATE 明瞭性と可読性を向上させるために、次のコードをリファクタリングしてください。日本語で返答ください。",
    },
    BetterNamings = {
      prompt = "/COPILOT_GENERATE 選択されたコードの変数名や関数名を改善してください。日本語で返答ください。",
    },
    Documentation = {
      prompt = "/COPILOT_GENERATE 選択範囲にドキュメントコメントを追加してください。日本語で返答ください。",
    },
    Tests = {
      prompt = "/COPILOT_GENERATE コードのテストを生成してください。日本語で返答ください。",
    },
    Wording = {
      prompt = "/COPILOT_GENERATE 次のテキストの文法と表現を改善してください。日本語で返答ください。",
    },
    Summarize = {
      prompt = "/COPILOT_GENERATE 選択範囲の要約を書いてください。日本語で返答ください。",
    },
    Spelling = {
      prompt = "/COPILOT_GENERATE 次のテキストのスペルミスを修正してください。日本語で返答ください。",
    },
    FixDiagnostic = {
      prompt = "ファイル内の次の問題を支援してください:",
      selection = select.diagnostics,
    },
    Commit = {
      prompt = "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
      selection = select.gitdiff,
    },
    CommitStaged = {
      prompt = "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
      selection = function(source)
        return select.gitdiff(source, true)
      end,
    },
  }
end

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  cmd = "CopilotChat",
  opts = function()
    local select = require("CopilotChat.select")
    return {
      model = "gpt-4o",
      auto_insert_mode = true,
      show_help = true,
      question_header = "  User ",
      answer_header = "  Copilot ",
      selection = function(source)
        return select.visual(source) or select.buffer(source)
      end,
      prompts = generate_prompts(select),
    }
  end,
  config = function(_, opts)
    local chat = require("CopilotChat")
    local cmp = require("cmp")
    cmp.setup.filetype("copilot-chat", {
      sources = {
        { name = "copilot" },
        { name = "snippets" },
        { name = "buffer" },
      },
    })

    chat.setup(opts)
  end,
  keys = {
    {
      "<leader>ha",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end,
      desc = "CopilotChat - Help actions",
    },
    {
      "<leader>hp",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end,
      desc = "CopilotChat - Prompt actions",
    },
    {
      "<leader>hi",
      function()
        local input = vim.fn.input("Ask Copilot: ")
        if input ~= "" then
          vim.cmd("CopilotChat " .. input)
        end
      end,
      desc = "CopilotChat - Ask input",
    },
    { "<leader>hd", "<cmd>CopilotChatDebugInfo<CR>", desc = "CopilotChat - Debug info" },
    { "<leader>hl", "<cmd>CopilotChatReset<CR>", desc = "CopilotChat - Clear buffer and chat history" },
    { "<leader>hv", "<cmd>CopilotChatToggle<CR>", desc = "CopilotChat - Toggle Vsplit" },
  },
}
