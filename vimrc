set encoding=UTF-8
set nocompatible
filetype off
set pyxversion=3
let g:python3_host_prog='/Users/uu094589/.anyenv/envs/pyenv/shims/python3'
let mapleader = "\<Space>"

call plug#begin('~/.vim/plugged')

" plugin manager
Plug 'VundleVim/Vundle.vim'

" doc
Plug 'vim-jp/vimdoc-ja'

" git
Plug 'airblade/vim-gitgutter'

" display
Plug 'kota718/dracula-vim', { 'branch': 'develop' } " 'dracula/vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'

" Plug 'edkolev/tmuxline.vim'

" languege
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'docunext/closetag.vim'
Plug 'slim-template/vim-slim'

" text object
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'cohama/lexima.vim'
Plug 'bronson/vim-trailing-whitespace'

" filer
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

" completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'ujihisa/neco-look'

" snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" otherr
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'thinca/vim-localrc'

call plug#end()

filetype plugin indent on

let g:indentLine_enabled = 1
autocmd FileType *
      \   if &l:omnifunc == ''
      \ |   setlocal omnifunc=syntaxcomplete#Complete
      \ | endif

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
set completeopt+=noinsert
set ambiwidth=double


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
nnoremap <Space>I :PlugInstall
nnoremap <Space>U :PlugUpdate

" Aireline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" NERDTree
let g:nerdtree_tabs_focus_on_files = 1
let NERDTreeShowHidden = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])

" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

nnoremap [nerdtree] <Nop>
nmap <Space>e [nerdtree]
nnoremap <silent> [nerdtree]t :NERDTreeToggle<CR>
nnoremap <silent> [nerdtree]f :NERDTreeFocus<CR>

" Fzf
nnoremap <Space>f :GFiles<CR>
nnoremap <Space>s :GFiles?<CR>
nnoremap <Space>b :Buffers<CR>
nnoremap <Space>t :Tags<CR>
nnoremap <Space>a :Ag<Space>

" vim-trailing-whitespace
autocmd BufWritePre * :FixWhitespace
let g:airline_powerline_fonts = 1

set guifont=Cica:h14
" loading the plugin
let g:webdevicons_enable = 1
" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1
" use double-width(1) or single-width(0) glyphs
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1
" the amount of space to use after the glyph character (default ' ')
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" Force extra padding in NERDTree so that the filetype icons line up vertically
"let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" Adding the custom source to denite
let g:webdevicons_enable_denite = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

set signcolumn=yes
let g:gitgutter_sign_column_always=1
