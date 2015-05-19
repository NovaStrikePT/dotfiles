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

" Vim 7.3+ specific features (for deployments with older versions of vim)
if version >= 703
	set colorcolumn=120
endif

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

" Change Command-T's default \b mapping to use most recently used buffer order
:nnoremap <silent> <leader>b :CommandTMRU<CR>

" Display Command-T matches in reverse order, with the best match at the bottom near the prompt
let g:CommandTMatchWindowReverse = 1

" Use powerline fonts
" Make sure the fonts have been installed; see https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1

" Use airline tabline extension interface with vertical separators
" Note that this overrides GUI tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

" Navigate buffers
" \h \l : go back/forward
nnoremap <Leader><Left> :bp<CR>
nnoremap <Leader><Right> :bn<CR>

" For non-gui vims, use the dark theme
if !has('gui_running')
	autocmd VimEnter * AirlineTheme dark
endif

syntax on
