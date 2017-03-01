if &compatible
  set nocompatible
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

" 基本設定
" スワップファイルを生成しない
set noswapfile
" 変更中に他ファイルを開く
set hidden
" マウスを有効にする
set mouse=a
" OS側のクリップボードを利用する
set clipboard+=unnamedplus
" ヤンクはクリップボードを利用する
set clipboard=unnamed
" 更新時に自動リロード
set autoread
" バックスペースでなんでも消せるように
set backspace=indent,eol,start
set expandtab

" 表示
" 行番号の表示
set number
" 編集中のファイル名を表示
set title
" カーソル行をハイライト
set cursorline
set cursorcolumn
" タブはスペース2
set tabstop=2
" 自動タブ幅もスペース2
set shiftwidth=2
" 自動インデント
set smartindent
" ルーラーを表示する
set ruler
set showcmd
" 対応する括弧をハイライト表示する
set showmatch
set nowrap

" 検索
" インクリメンタルサーチを有効にする
set incsearch


" color
syntax enable
set background=dark
colorscheme solarized

" ===== alias =====
"vertical size adjust '<' '>'
nnoremap <silent>< <C-w><
nnoremap <silent>> <C-w>>
"horizonal size adjust '+' '-'
noremap <silent>+ <C-w>+
noremap <silent>- <C-w>-


