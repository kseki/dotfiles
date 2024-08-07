local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- File type settings
-- autocmd({"BufNewFile", "BufRead", "BufReadPre"}, {
-- 	pattern = {
-- 		"*.jbuilder",
-- 		"Guardfile",
-- 		"Rakefile",
-- 		"Vagrantfile",
-- 		"Gemfile",
-- 		".pryrc",
-- 		"*.thor",
-- 	},
-- 	command = "set filetype = ruby",
-- })

autocmd({ "BufNewFile", "BufRead", "BufReadPre" }, {
	pattern = {
		".eslintrc",
		".stylelintrc",
	},
	command = "set filetype=ruby",
})

autocmd({ "BufNewFile", "BufRead", "BufReadPre" }, {
	pattern = {
		".yamllint",
	},
	command = "set filetype=yaml",
})

-- Remove whitespace on save
autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
	pattern = "*",
	command = "set fo-=c fo-=r fo-=o",
})

-- Restore cursor location when file is opened
autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})

-- set wrap for markdown files
autocmd("BufRead", {
	pattern = "*.md",
	command = "setlocal wrap",
})

-- Create a directory if one does not exist when saving a file
autocmd("BufWritePre", {
	pattern = "*",
	command = "call mkdir(expand('%:p:h'), 'p')",
})
