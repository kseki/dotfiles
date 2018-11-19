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
Plug 'tpope/vim-fugitive'

" display
"Plug 'kota718/dracula-vim', { 'branch': 'develop' } " 'dracula/vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
"Plug 'majutsushi/tagbar'

" Plug 'edkolev/tmuxline.vim'

" languege
"Plug 'sheerun/vim-polyglot'
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
Plug 'junegunn/vim-peekaboo'

" completion
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'yami-beta/asyncomplete-omni.vim'

"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'ujihisa/neco-look'

" snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" operator
Plug 'kana/vim-operator-user'
Plug 'tyru/operator-camelize.vim'

" other
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'thinca/vim-localrc'
Plug 'wakatime/vim-wakatime'

" ruby
Plug 'vim-ruby/vim-ruby'
Plug 'bronson/vim-ruby-block-conv'
Plug 'tpope/vim-haml'
Plug 'slim-template/vim-slim'

" Javascript
Plug 'posva/vim-vue'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'elzr/vim-json', { 'for': 'json' }

" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'ryanolsonx/vim-lsp-typescript'
Plug 'runoshun/tscompletejob'
Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" markdown
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'previm/previm', { 'for': 'markdown' }
Plug 'suzuki-hoge/table-converter', { 'for': 'markdown' }

" fish script
Plug 'dag/vim-fish', { 'for': 'fish' }

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

set completeopt=menuone

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
"set completeopt+=noinsert
set ambiwidth=double

" シンタックスハイライトを有効化
syntax on

let g:dracula_italic = 0
color dracula

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

"colorscheme Dracula

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

nnoremap - <C-a>
nnoremap + <C-x>

" Vundle
nnoremap <Space>I :PlugInstall
nnoremap <Space>U :PlugUpdate

" s*でカーソル下のキーワードを置換
nnoremap <expr> s* ':%s/\<' . expand('<cword>') . '\>/'
vnoremap <expr> s* ':s/\<' . expand('<cword>') . '\>/'

" Aireline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" NERDTree
let g:nerdtree_tabs_focus_on_files = 1
let NERDTreeShowHidden = 1

" deoplete
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#auto_complete_start_length = 1
"inoremap <expr><tab> pumvisible() ? "\<C-n>" :
"      \ neosnippet#expandable_or_jumpable() ?
"      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
"
"" <CR>: close popup and save indent.
""inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
""function! s:my_cr_function() abort
""  return deoplete#close_popup() . "\<CR>"
""endfunction
"
"call deoplete#custom#source('_', 'converters', [
"      \ 'converter_remove_paren',
"      \ 'converter_remove_overlap',
"      \ 'converter_truncate_abbr',
"      \ 'converter_truncate_menu',
"      \ 'converter_auto_delimiter',
"      \ ])
"call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])
"
" vim-lsp

let g:lsp_auto_enable = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_enabled = 1
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}

if executable('solargraph')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

if executable('css-languageserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'css-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
        \ 'whitelist': ['css', 'less', 'sass'],
        \ })
endif

" TypeScript
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript'],
        \ })
endif

" asyncomplete
let g:asyncomplete_remove_duplicates = 1

call asyncomplete#register_source(asyncomplete#sources#tscompletejob#get_source_options({
      \ 'name': 'tscompletejob',
      \ 'whitelist': ['typescript'],
      \ 'completor': function('asyncomplete#sources#tscompletejob#completor'),
      \ }))

call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
      \ 'name': 'omni',
      \ 'whitelist': ['*'],
      \ 'blacklist': ['c', 'cpp', 'html'],
      \ 'completor': function('asyncomplete#sources#omni#completor')
      \  }))

au User asyncomplete_setup call  asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'whitelist': ['*'],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'whitelist': ['*'],
      \ 'blacklist': ['go'],
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ }))

call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
      \ 'name': 'neosnippet',
      \ 'whitelist': ['*'],
      \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
      \ }))

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" neosnippet
"imap <C-k> <Plug>(neosnippet_expand_or_jump)
"smap <C-k> <Plug>(neosnippet_expand_or_jump)
"xmap <C-k> <Plug>(neosnippet_expand_target)
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

nnoremap [nerdtree] <Nop>
nmap <Space>e [nerdtree]
nnoremap <silent> [nerdtree]t :NERDTreeToggle<CR>
nnoremap <silent> [nerdtree]f :NERDTreeFind<CR>

" Fzf
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('down:40%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <Space>f :GFiles<CR>
nnoremap <Space>s :GFiles?<CR>
nnoremap <Space>b :Buffers<CR>
nnoremap <Space>t :Tags<CR>
nnoremap <space>x :Commands<CR>
nnoremap <Space>l :Lines<Space>
nnoremap <Space>a :Rg<Space>
nnoremap <Space>aw :Rg<Space><C-r><C-w>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" vim-trailing-whitespace
autocmd BufWritePre * :FixWhitespace
let g:airline_powerline_fonts = 1

set guifont=Cica:h14
" loading the plugin
let g:webdevicons_enable = 1
"" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1
"" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
"" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
"" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1
"" use double-width(1) or single-width(0) glyphs
"" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
"" whether or not to show the nerdtree brackets around flags
"let g:webdevicons_conceal_nerdtree_brackets = 1
"" the amount of space to use after the glyph character (default ' ')
""let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
"" Force extra padding in NERDTree so that the filetype icons line up vertically
""let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
"" Adding the custom source to denite
"let g:webdevicons_enable_denite = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1

if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

" fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gr :Gread
nnoremap <Leader>grm :Gremove
nnoremap <Leader>gco :Gcommit<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit

" ale
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0


" vim-markdown
let g:vim_markdown_folding_disabled = 1
" previm
let g:previm_open_cmd = 'gnome-www-browser'
nnoremap [previm] <Nop>
nmap <Leader>p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>

" operator-camelize
map <leader>c <plug>(operator-camelize-toggle)

" vim-json
let g:vim_json_syntax_conceal = 0

function! ProfileCursorMove() abort
  let profile_file = expand('~/log/vim-profile.log')
  if filereadable(profile_file)
    call delete(profile_file)
  endif

  normal! gg
  normal! zR

  execute 'profile start ' . profile_file
  profile func *
  profile file *

  augroup ProfileCursorMove
    autocmd!
    autocmd CursorHold <buffer> profile pause | q
  augroup END

  for i in range(100)
    call feedkeys('j')
  endfor
endfunction

" tagbar
" noremap <F8> :TagbarToggle<CR>
