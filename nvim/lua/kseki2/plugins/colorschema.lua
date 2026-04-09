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
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
      require("dracula").setup({
        overrides = {
          -- tabby.nvim が使う TabLine 系グループを Dracula Pro 配色で上書き
          TabLineFill = { bg = "#17161D" },
          TabLine     = { fg = "#7970A9", bg = "#2E2B3B" },
          TabLineSel  = { fg = "#F8F8F2", bg = "#22212C", bold = true },
        },
        colors = {
          -- Dracula Pro palette overrides
          bg          = "#22212C",
          fg          = "#F8F8F2",
          selection   = "#454158",
          comment     = "#7970A9",
          red         = "#FF9580",
          orange      = "#FFCA80",
          yellow      = "#FFFF80",
          green       = "#8AFF80",
          purple      = "#9580FF",
          cyan        = "#80FFEA",
          pink        = "#FF80BF",
          bright_red  = "#FFAA99",
          bright_green = "#A2FF99",
          bright_yellow = "#FFFF99",
          bright_cyan = "#99FFEE",
          menu        = "#2E2B3B",
          visual      = "#454158",
          black       = "#17161D",
        },
      })
      vim.cmd("colorscheme dracula")
    end,
  },
}
