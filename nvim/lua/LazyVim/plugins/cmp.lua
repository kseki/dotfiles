return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-cmdline",
  },
  opts = function(_, opts)
    local auto_select = false
    opts.completion = {
      completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
    }

    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

    local cmp = require("cmp")

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_prefix_unmatching = true,
        disallow_symbol_nonprefix_matching = false,
      },
    })
  end,
}
