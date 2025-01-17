-- ファイル保存時にディレクトリがなかったら作成するか問う
vim.api.nvim_create_augroup('vimrc_auto_mkdir', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'vimrc_auto_mkdir',
  pattern = '*',
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if not vim.fn.isdirectory(dir) then
      local create = vim.fn.input(string.format('"%s" does not exist. Create? [y/N]', dir))
      if create:match('^y') then
        vim.fn.mkdir(vim.fn.iconv(dir, vim.o.encoding, vim.o.termencoding), 'p')
      end
    end
  end,
})
