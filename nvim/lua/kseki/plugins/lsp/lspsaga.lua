local saga_status, lspsaga = pcall(require, "lspsaga")
if not saga_status then
  return
end

lspsaga.setup({
  -- keybinds for navigation in lspsaga window
  scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
  -- use enter to open file with definition preview
  definition = {
    edit = "<CR>",
  },
})
