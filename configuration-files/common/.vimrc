" VIM works better with a more POSIX-compliant shell
if &shell =~# 'fish$'
	set shell=sh
endif

" We like `:filetype`, therefore nocompatible
set nocompatible

" May want to set `g:plug_threads`
" See https://github.com/junegunn/vim-plug/issues/502

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Install these from Github repos
" Make sure you use single quotes
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'dag/vim-fish'
Plug 'tpope/vim-fugitive'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'

call plug#end()
" Automatically executes `filetype plugin indent on` and `syntax enable`

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

" Set splits to appear below/right
set splitbelow
set splitright

" Allow hidden modified buffers
set hidden
set bufhidden=

" Ignore middle mouse clicks
nnoremap <MiddleMouse>   <Nop>
nnoremap <2-MiddleMouse> <Nop>
nnoremap <3-MiddleMouse> <Nop>
nnoremap <4-MiddleMouse> <Nop>

inoremap <MiddleMouse>   <Nop>
inoremap <2-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>

" Press Space to turn off search highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Use powerline fonts
" Make sure the fonts have been installed; see https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1

" Navigate window splits
nnoremap <silent> <A-D-Up> :wincmd k<CR>
nnoremap <silent> <A-D-Down> :wincmd j<CR>
nnoremap <silent> <A-D-Left> :wincmd h<CR>
nnoremap <silent> <A-D-Right> :wincmd l<CR>
inoremap <silent> <A-D-Up> <C-o>:wincmd k<CR>
inoremap <silent> <A-D-Down> <C-o>:wincmd j<CR>
inoremap <silent> <A-D-Left> <C-o>:wincmd h<CR>
inoremap <silent> <A-D-Right> <C-o>:wincmd l<CR>

" Navigate buffers
" \h \l : go back/forward
nnoremap <Leader><Left>  :bprevious<CR>
nnoremap <Leader><Right> :bnext<CR>

" Navigate tabs
nnoremap <leader>[ :tabprevious<CR>
nnoremap <leader>] :tabnext<CR>

" Disable indentLine by default
let g:indentLine_enabled = 0
" Performance increase, but some syntax highlighting may be incorrect? TODO: test
let g:indentLine_faster = 1

" Prevent indentLine from overriding `conceal…` for problematic file types
" See also https://github.com/Yggdroot/indentLine/issues/140
augroup indentLineConceal
	autocmd!
	autocmd Filetype json,markdown let g:indentLine_setConceal = 0
augroup END

" Copied from $VIMRUNTIME/vimrc_example.vim
" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
	au!

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

	augroup END
endif
" End copied from $VIMRUNTIME/vimrc_example.vim

" For non-gui vims, use the dark theme
if !has('gui_running')
	augroup nonGuiTheme
		autocmd!
		autocmd VimEnter * AirlineTheme dark
	augroup END
endif
