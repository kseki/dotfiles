set encoding=UTF-8
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugin manager
Plugin 'VundleVim/Vundle.vim'

" doc
Plugin 'vim-jp/vimdoc-ja'

" git
Plugin 'airblade/vim-gitgutter'

" display
Plugin 'kota718/dracula-vim' " 'dracula/vim'
Plugin 'Yggdroot/indentLine'
Plugin 'vim-airline/vim-airline'
Plugin 'ryanoasis/vim-devicons'
 
" Plugin 'edkolev/tmuxline.vim'

" languege
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise'
Plugin 'docunext/closetag.vim'

" text object
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'cohama/lexima.vim'

" filer
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'

call vundle#end()

filetype plugin indent on

let g:indentLine_enabled = 1

" 行番号の表示
set number
set numberwidth=4
" カーソル位置の表示
set ruler

" 画面分割の設定
set splitbelow
set splitright

" 未保存でもバッファーの切り替えを可能にする
set hidden
" カーソル下に表示する最低行数
set scrolloff=999
" 入力中のコマンドを表示
set showcmd
" 長文を折り返して表示
set display=lastline

" ファイルの自動読み込み
set autoread
" バックスペースを有効化
set backspace=indent,eol,start
" 対応するカッコに一瞬カーソル表示する
set showmatch
set matchtime=1

" タブ幅の設定
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"" === 検索 ===
" 大文字と小文字を無視する
set ignorecase
" 大文字と小文字を無視しない
set noignorecase
" 検索パターンが大文字を含んでいたら'ignorecase'を上書きする。('ignorecase'オンのときのみ使われる)
set smartcase
" 'ignorecase'を上書きしない
set nosmartcase
" 行末まで検索したら行頭へ
set wrapscan
" 検索対象をハイライト
set hlsearch

" ヘルプ画面の高さ
set helpheight=999
" カーソル下の単語のヘルプを開く
set keywordprg=:help
set title

" シンタックスハイライトを有効化
syntax on

" バックアップの間隔変更 
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

" ファイルの自動再読込
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

colorscheme Dracula

" === 検索 ===
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
noremap <Space>s :%s/

" === カーソル移動 ===
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap H ^
nnoremap L $

" === ウィンドウ移動 ===
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" === スペルチェック ===
nnoremap <silent> <Space>os :<C-u>setlocal spell! spell?<CR>
nnoremap <silent> <Space>op :<C-u>set paste! paste?<CR>

" === Others ===
nnoremap s. :<C-u>source $MYVIMRC<CR>
map <Space>i gg=<S-g><C-o><C-o>zz

nnoremap Y y$

nnoremap <Space>q :<C-u>q<CR>
nnoremap <Space>qa :<C-u>qa<CR>
nnoremap <Space>w :<C-u>w<CR>
nnoremap <Space>wq :<C-u>wq<CR>

nnoremap + <C-a>
nnoremap - <C-x>

" Vundle
nnoremap <Space>I :PluginInstall
nnoremap <Space>U :PluginUpdate

" Aireline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" NERDTree
let g:nerdtree_tabs_focus_on_files = 1
let NERDTreeShowHidden = 1

nnoremap [nerdtree] <Nop>
nmap <Space>e [nerdtree]
nnoremap <silent> [nerdtree]t :NERDTreeToggle<CR>
nnoremap <silent> [nerdtree]f :NERDTreeFocus<CR>

" Fzf
nnoremap <Space>b :Buffers
nnoremap <Space>t :Tags
nnoremap <Space>a :Ag
