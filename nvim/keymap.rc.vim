let g:mapleader = "\<Space>"

" Move cursor
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap H ^
nnoremap L $

nnoremap Y y$

nnoremap <C-j> }
nnoremap <C-k> {

nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Left> <C-w>h
nnoremap <Right> <C-w>l

nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

nnoremap <Leader>q :<C-u>q<CR>
nnoremap <Leader>qa :<C-u>qa<CR>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>wq :<C-u>wq<CR>

" Code format
nnoremap <Leader>i gg=G

nnoremap <Leader>s. :<C-u>source $MYVIMRC<CR>
nnoremap <Leader>m  :<C-u>marks<CR>
nnoremap <Leader>r  :<C-u>registers<CR>

" Surrounding words
nnoremap <Leader>s" ciw""<Esc>P
nnoremap <Leader>s' ciw''<Esc>P
nnoremap <Leader>s` ciw``<Esc>P
nnoremap <Leader>s( ciw()<Esc>P
nnoremap <Leader>s{ ciw{}<Esc>P
nnoremap <Leader>s[ ciw[]<Esc>P

" Print current date
inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>

" Help
nnoremap <C-h> :<C-u>vertical belowright help<Space>
nnoremap <C-H> :<C-u>vertical belowright help<Space><C-r><C-w>


" Toggle options
nnoremap <silent> <Leader>os :<C-u>setlocal spell! spell?<CR>
nnoremap <silent> <Leader>op :<C-u>set paste! paste?<CR>

" Terminal
if has('nvim')
  nnoremap @t :split<CR>:terminal<CR>
	tnoremap <ESC><ESC> <C-\><C-n>:q<CR>
	tnoremap <ESC> <C-\><C-n>
endif

" Git
nnoremap <Leader>G :tab terminal ++close lazygit<CR>
