set nocompatible               " be iMproved

" Vundle
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Core
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'taglist.vim'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
" Languages Specific
Bundle 'davidhalter/jedi-vim'
" regarder honza/vimsnippets pour info

" Vim 
syntax enable
filetype plugin indent on
set number
set encoding=utf-8
set showcmd

set backspace=eol,start,indent
set omnifunc=syntaxcomplete#Complete

let mapleader = ","
let g:mapleader = ","

" bar
set wildmenu
set ruler
set laststatus=2

" search
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
map <silent>// :noh<cr>

"spaces and tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" brackets
set showmatch
set mat=2

" cursor
set so=10

" errors no soudn no blink
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" backups, swaps
set nobackup
set nowb
set noswapfile

" folding
set foldlevel=99

" Visual mode pressing * or # 
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


" Return to last edit position when opening 
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


" Delete trailing white space 
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" autoreload vimrc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }



" plugins
set background=light
let g:solarized_termcolors=256
colorscheme solarized

" Taglist.vim
nnoremap <silent> <F8> :TlistToggle<CR>
set statusline=%<%f%=%([%{Tlist_Get_Tagname_By_Line()}]%)
let Tlist_Process_File_Always=1

