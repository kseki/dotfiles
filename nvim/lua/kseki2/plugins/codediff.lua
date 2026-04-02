return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  opts = {
    layout = "side-by-side",
    compute_moves = true,
    ignore_trim_whitespace = false,
  },
  keys = {
    { "<leader>dd", "<cmd>CodeDiff<cr>", desc = "CodeDiff: Open" },
  },
}
