return {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task build:fast",
  config = function()
    require("peek").setup()
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
  keys = {
    { "<leader>mp", "<cmd>PeekOpen<cr>", desc = "Peek Open", ft = "markdown" },
  },
}
