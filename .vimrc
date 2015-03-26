set nocompatible
filetype off

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Install these from Github repos
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'wincent/command-t'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set backspace=indent,eol,start

set directory^=$HOME/.vim/.swap_files

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1

set ruler
set colorcolumn=120

"Use soft wrapping
set textwidth=0
set linebreak
set wrap

set laststatus=2
set autoindent

set incsearch
set hlsearch

" Use airline tabline extension for non-gui vims; let GUI vims use their own tabbing interface
if !has('gui_running')
	let g:airline#extensions#tabline#enabled = 1
endif

syntax on
