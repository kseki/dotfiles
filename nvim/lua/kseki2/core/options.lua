local opt = vim.opt

opt.autoread = true
opt.encoding = "utf-8"
opt.shell = "/bin/zsh"
opt.termguicolors = true

-- Line numbers
opt.relativenumber = true
opt.number = true
opt.numberwidth = 5

opt.wrap = false

-- Tab & Indentation
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Search settings
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

-- Cursor line
opt.cursorline = true
opt.scrolloff = 999

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--  Split windows
opt.splitright = true
opt.splitbelow = true

-- Statusline
opt.laststatus = 3

opt.iskeyword:append("-")
