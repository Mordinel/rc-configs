set number
set expandtab
set tabstop=4
set softtabstop=0 
set shiftwidth=4
set smarttab
set ai
set si
set sc
set autoread
colo default
set background=dark
set encoding=utf8
set hlsearch
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

let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_browse_split=4

command! MakeTags !ctags -R .

syntax on
filetype plugin indent on

source /home/sg/.vim/snippets/vimrc_snippets
