vim.g.mapleader = " "

local keymap = vim.keymap -- For conciseness

-- General keymaps

keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<Esc><Esc>", "<cmd><C-u>noh<CR>")

keymap.set("n", "x", '"_x')

keymap.set("n", "<Leader>+", "<C-a>")
keymap.set("n", "<Leader>-", "<C-x>")

keymap.set("n", "<Leader>sv", "<C-w>v")
keymap.set("n", "<Leader>sh", "<C-w>s")
keymap.set("n", "<Leader>se", "<C-w>=")
keymap.set("n", "<Leader>sx", "<cmd>close<CR>")

keymap.set("n", "<Leader>to", "<cmd>tabnew<CR>")
keymap.set("n", "<Leader>tx", "<cmd>tabclose<CR>")
keymap.set("n", "<Leader>tn", "<cmd>tabnext<CR>")
keymap.set("n", "<Leader>tp", "<cmd>tabprevious<CR>")

-- Plugin keymaps

-- vim-maximizer
keymap.set("n", "<Leader>sm", "<cmd>MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<Leader>e", "<cmd>NvimTreeToggle<CR>")
keymap.set("n", "<Leader>ee", "<cmd>NvimTreeFindFileToggle<CR>")

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

-- lazygit
keymap.set("n", "<Leader>gg", ":LazyGit<CR>")

-- markdown-preview
keymap.set("n", "<Leader>op", "<cmd>MarkdownPreview<CR>")

-- vim-quickhl
keymap.set("n", "<Space>m", "<Plug>(quickhl-manual-this)", { noremap = false })
keymap.set("x", "<Space>m", "<Plug>(quickhl-manual-this)", { noremap = false })
keymap.set("n", "<Space>M", "<Plug>(quickhl-manual-reset)", { noremap = false })
keymap.set("x", "<Space>M", "<Plug>(quickhl-manual-reset)", { noremap = false })

-- open-browser
keymap.set("n", "<Leader>o", "<Plug>(openbrowser-open)")
keymap.set("v", "<Leader>os", "<Plug>(openbrowser-smart-search)")

-- open-browser-github
keymap.set("n", "<Leader>og", "<cmd>OpenGithubFile<CR>")
keymap.set("v", "<Leader>og", "<cmd>OpenGithubFile<CR>")
