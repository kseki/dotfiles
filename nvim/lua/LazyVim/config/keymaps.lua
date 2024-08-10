-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- space + p で ~/.config/nvim/snippets/${filetype}.json を開く
vim.keymap.set("n", "<Space>p", function()
  local filetype = vim.bo.filetype
  local path = string.format("~/.config/nvim/snippets/%s.json", filetype)
  vim.cmd("e " .. path)
end, { noremap = true, silent = true })
