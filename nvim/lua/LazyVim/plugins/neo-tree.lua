return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts["filesystem"]["filtered_items"] = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
      hide_by_name = {
        ".DS_Store",
        "thumbs.db",
        "node_modules",
      },
    }
  end,
}
