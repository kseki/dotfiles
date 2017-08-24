set autoread
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
set expandtab
set helpheight=999
set hidden
set history=1000
set ignorecase
set incsearch
set list
set matchtime=1
set mouse=a
set noswapfile
set nowrap
set number
set numberwidth=5
set pumheight=15
set ruler
set scrolloff=8
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set smartindent
set splitbelow
set splitright
set tabstop=2
set title
set whichwrap=b,s,h,l,<,>,[,]
set wrapscan

set updatetime=2000

" カーソルラインの表示
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      setlocal cursorcolumn
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
      setlocal nocursorcolumn
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          setlocal nocursorcolumn
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      setlocal cursorcolumn
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END
