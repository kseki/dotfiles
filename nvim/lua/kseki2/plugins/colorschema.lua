return {
  {
    "navarasu/onedark.nvim",
    enabled = false,
    config = function()
      require("onedark").load()
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    enabled = false,
    config = function()
      vim.cmd("colorscheme nordfox")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          blink_cmp = true,
          gitsigns = true,
          treesitter = true,
          which_key = true,
          lsp_trouble = true,
          snacks = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
