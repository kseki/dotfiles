vim.g.mapleader = " "

local keymap = vim.keymap -- For conciseness
local opts = { noremap = true, silent = true }

-- General keymaps

keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<Esc><Esc>", ":<C-u>nohlsearch<CR>", opts)

keymap.set("n", "<Leader>q", ":<C-u>q<CR>", opts)
keymap.set("n", "<Leader>qa", ":<C-u>qa<CR>", opts)
keymap.set("n", "<Leader>w", ":<C-u>w<CR>", opts)
keymap.set("n", "<Leader>wq", ":<C-u>wq<CR>", opts)

keymap.set("n", "x", '"_x', opts)

keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "-", "<C-x>", opts)

keymap.set("n", "to", ":<C-u>tabnew<CR>", opts)
keymap.set("n", "tx", ":<C-u>tabclose<CR>", opts)
keymap.set("n", "tn", ":<C-u>tabnext<CR>", opts)
keymap.set("n", "tp", ":<C-u>tabprevious<CR>", opts)

-- Plugin keymaps

-- vim-maximizevsv
keymap.set("n", "<Leader>sm", ":<C-u>MaximizerToggle<CR>", opts)

-- nvim-tree
keymap.set("n", "<Leader>e", ":<C-u>NvimTreeToggle<CR>", opts)
keymap.set("n", "<Leader>ee", ":<C-u>NvimTreeFindFileToggle<CR>", opts)

-- telescope
keymap.set("n", "<Leader>f", ":<C-u>Telescope find_files<CR>", opts)
keymap.set("n", "<Leader>s", ":<C-u>Telescope git_status<CR>", opts)
keymap.set("n", "<Leader>a", ":<C-u>Telescope live_grep<CR>", opts)
keymap.set("n", "<Leader>aw", ":<C-u>Telescope grep_string<CR>", opts)
keymap.set("n", "<Leader>r", ":<C-u>Telescope registers<CR>", opts)
keymap.set("n", "<Leader>b", ":<C-u>Telescope buffers<CR>", opts)
keymap.set("n", "<Leader>c", ":<C-u>Telescope commands<CR>", opts)
keymap.set("n", "<Leader>h", ":<C-u>Telescope help_tags<CR>", opts)
keymap.set("i", "<C-r>", function()
	require("telescope.builtin").registers(require("telescope.themes").get_cursor())
end, opts)

-- lazygit
keymap.set("n", "<Leader>gg", ":<C-u>LazyGit<CR>", opts)

-- markdown-preview
keymap.set("n", "<Leader>op", ":<C-u>MarkdownPreview<CR>", opts)

-- vim-quickhl
keymap.set("n", "<Space>m", "<Plug>(quickhl-manual-this)", { noremap = false })
keymap.set("x", "<Space>m", "<Plug>(quickhl-manual-this)", { noremap = false })
keymap.set("n", "<Space>M", "<Plug>(quickhl-manual-reset)", { noremap = false })
keymap.set("x", "<Space>M", "<Plug>(quickhl-manual-reset)", { noremap = false })

-- open-browser
keymap.set("n", "<Leader>o", "<Plug>(openbrowser-open)", opts)
keymap.set("v", "<Leader>os", "<Plug>(openbrowser-smart-search)", opts)

-- open-browser-github
keymap.set("n", "<Leader>og", "<cmd>OpenGithubFile<CR>", opts)
keymap.set("v", "<Leader>og", "<cmd>OpenGithubFile<CR>", opts)

-- tabline
keymap.set("n", "<Leader>tr", "<cmd>TablineTabRename ", opts)
