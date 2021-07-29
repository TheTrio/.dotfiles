call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

call plug#end()

set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
set noshowmode
syntax on
colorscheme onedark
set number
