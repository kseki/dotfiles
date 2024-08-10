return {
  "CopilotC-Nvim/CopilotChat.nvim",
  cmd = "CopilotChat",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  opts = {
    prompt = {},
  },
}
