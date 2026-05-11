local function snippet_search_paths()
  local paths = { vim.fn.stdpath("config") .. "/snippets" }
  local project_snippets = vim.fn.getcwd() .. "/.nvim/snippets"
  if (vim.uv or vim.loop).fs_stat(project_snippets) then
    table.insert(paths, 1, project_snippets)
  end
  return paths
end

return {
  "saghen/blink.cmp",
  dependencies = {
    "fang2hou/blink-copilot",
    {
      "zbirenbaum/copilot.lua",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      },
    },
    "rafamadriz/friendly-snippets",
  },
  version = "*",
  opts = {
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
      ["<C-k>"] = { "snippet_forward", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "copilot", "lsp", "path", "snippets", "buffer" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        snippets = {
          opts = {
            search_paths = snippet_search_paths(),
          },
        },
      },
    },
    cmdline = {
      sources = { "cmdline" },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      list = { selection = { preselect = false } },
      menu = { border = "rounded" },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
    },
  },
}
