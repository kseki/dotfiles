set encoding=utf-8
set guifont=Cica:h16
set printfont=Cica:h12
set ambiwidth=double

set number                       " 行番号表示
set numberwidth=5                " 行番号の列数
set ruler                        " カーソル位置を表示
set showcmd                      " 入力コマンド表示

set autoindent                   " 自動インデント
set autowrite

set tabstop=2                    " タブ幅の設定
set softtabstop=2
set shiftwidth=2
set expandtab                    " タブの代わりにスペースにする
set smarttab                     " 行頭でタブを入力するとインデントを合わせる
set shiftround

set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split
set history=5000

set autoread
set backspace=indent,eol,start
set helpheight=999
set hidden
set nobackup
set nowritebackup
set list
set matchtime=1
set mouse=a
set noswapfile
set nowrap
set pumheight=15
set scrolloff=999
set showmatch
set smartindent
set splitbelow
set splitright
set title
set whichwrap=b,s,h,l,<,>,[,]
set inccommand=split
set completeopt=menuone,noinsert

set cmdheight=2
set updatetime=300
set shortmess+=c

if has('nvim')
  set termguicolors
endif

" Abbreviations (短縮入力)
iabbrev udpate update
iabbrev destory destroy
iabbrev recieve receive

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

" ファイルの自動再読込
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END
