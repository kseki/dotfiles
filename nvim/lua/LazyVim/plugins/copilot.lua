return {
  "zbirenbaum/copilot.lua",
  opts = function(_, opts)
    opts.filetypes = {
      markdown = true,
      help = true,
    }
    opts.filetypes["copilot-chat"] = true
  end,
}
