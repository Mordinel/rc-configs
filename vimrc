set relativenumber
set expandtab
set tabstop=4
set softtabstop=0 
set shiftwidth=4
set smarttab
set ai
set si
set sc
set autoread
set background=dark
set encoding=utf8
set incsearch
set ignorecase
set showmatch
set mat=2
set noswapfile
set nowb
set nobackup
set nomodeline
set nocompatible
set viminfo="NONE"
set nojoinspaces
set selection=exclusive
set fileformats=unix,dos
set fileformat=unix
set shellslash
set lazyredraw
set scrolloff=4
set showcmd
set so=7
set path+=**
set wildmenu
set backspace=indent,eol,start

let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_browse_split=4

command! Hex %!xxd
command! Bin %!xxd -r

syntax on
colo delek
filetype plugin indent on
highlight Normal ctermbg=NONE

" vim-plug
call plug#begin('~/.vim/plugged')

" Tab completion for code completion
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

" C++ code completion
Plug 'xavierd/clang_complete'

" C++ enhanced syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Python code completion
Plug 'davidhalter/jedi-vim'

call plug#end()
