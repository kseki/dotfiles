local kopts = { noremap = true, silent = true }

return {
	'kevinhwang91/nvim-hlslens',
	keys = { { 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts }, { 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts }, { '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts }, { '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts }, { 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts }, { 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts }, { '<Leader>l', '<Cmd>noh<CR>', kopts }, } }
