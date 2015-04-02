" VIM works better with a more POSIX-compliant shell
if &shell =~# 'fish$'
	set shell=sh
endif

set nocompatible
filetype on
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
Plugin 'dag/vim-fish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
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

" Press Space to turn off search highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Use powerline fonts
" Make sure the fonts have been installed; see https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1

" For non-gui vims, use use airline tabline extension and dark theme
" Let GUI vims use their own tabbing interface
if !has('gui_running')
	let g:airline#extensions#tabline#enabled = 1
	autocmd VimEnter * AirlineTheme dark
endif

syntax on
