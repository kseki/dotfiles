return {
  "garymjr/nvim-snippets",
  opts = function(_, opts)
    opts.search_path = {
      "~/.config/nvim/snippets",
    }
  end,
  keys = {
    {
      "<Leader>cp",
      function()
        local filetype = vim.bo.filetype
        local path = string.format("~/.config/nvim/snippets/%s.json", filetype)
        vim.cmd("e " .. path)
      end,
      desc = "Open snippets file",
    },
  },
}
