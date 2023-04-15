vim.g.mapleader = " "

local keymap = vim.keymap -- For conciseness

-- General keymaps

keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<Esc><Esc>", ":<C-u>noh<CR>")

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")

keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabnext<CR>")
keymap.set("n", "<leader>tp", ":tabprevious<CR>")

-- Plugin keymaps

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<Leader>f", "<cmd>Telescope find_files<CR>")
keymap.set("n", "<Leader>s", "<cmd>Telescope git_status<CR>")
keymap.set("n", "<Leader>a", "<cmd>Telescope live_grep<CR>")
keymap.set("n", "<Leader>aw", "<cmd>Telescope grep_string<CR>")
keymap.set("n", "<Leader>r", "<cmd>Telescope registers<CR>")
keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<CR>")
keymap.set("n", "<Leader>c", "<cmd>Telescope commands<CR>")
keymap.set("n", "<Leader>h", "<cmd>Telescope help_tags<CR>")
keymap.set("i", "<C-r>", function()
	require("telescope.builtin").registers(require("telescope.themes").get_cursor())
end)
