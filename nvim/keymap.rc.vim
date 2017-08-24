" Move cursor
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

nnoremap s <Nop>
nnoremap ss s
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

"vertical size adjust '<' '>'
nnoremap <silent>< <C-w><
nnoremap <silent>> <C-w>>
"horizonal size adjust '+' '-'
nnoremap <silent>+ <C-w>+
nnoremap <silent>- <C-w>-

" tab
nnoremap tt  :<C-u>tabnew<CR>
nnoremap tq  :<C-u>tabclose<CR>
nnoremap s] gt
nnoremap s[ gT

