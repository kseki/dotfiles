local opt = vim.opt -- For conciseness

opt.autoread = true
opt.encoding = "utf-8"

-- Line numbers
opt.relativenumber = true
opt.number = true
opt.numberwidth = 5

-- Tab & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

--  Split windows
opt.splitright = true
opt.splitbelow = true

-- Statusline
opt.laststatus = 3

opt.iskeyword:append("-")
