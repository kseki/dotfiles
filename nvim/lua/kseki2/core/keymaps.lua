local keymap = vim.keymap -- For conciseness
local opts = { noremap = true, silent = true }

keymap.set("n", "<Esc><Esc>", ":<C-u>nohlsearch<CR>", opts)

keymap.set("n", "<Leader>q", ":<C-u>q<CR>", opts)
keymap.set("n", "<Leader>qa", ":<C-u>qa<CR>", opts)
keymap.set("n", "<Leader>w", ":<C-u>w<CR>", opts)
keymap.set("n", "<Leader>wq", ":<C-u>wq<CR>", opts)

keymap.set("n", "x", '"_x', opts)

keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "-", "<C-x>", opts)
