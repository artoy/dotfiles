set incsearch
" 検索結果をハイライト表示
set hlsearch

set number
set guioptions+=a


syntax on

inoremap <silent> jj <ESC>

let mapleader = "\<Space>"

nnoremap <Leader>l $
vnoremap <Leader>l $
nnoremap <Leader>h 0
vnoremap <Leader>h 0
nnoremap <Leader>j 8j
vnoremap <Leader>j 8j
nnoremap <Leader>k 8k
vnoremap <Leader>k 8k
nnoremap <Leader>a ggvG$
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
 
