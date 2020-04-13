" With visualbell enabled (see .vimrc), we also want to disable the flash
" That is, "If 't_vb' is cleared and 'visualbell' is set, no beep and no flash will ever occur"
" Source: https://vim.fandom.com/wiki/Disable_beeping
set t_vb=

set guitablabel=%N.\ %M%t

colorscheme solarized

" Create preset dark and light themes. Default to light.
command AirlineThemeDark set background=dark | AirlineTheme luna
command AirlineThemeLight set background=light | AirlineTheme papercolor
augroup guiTheme
	autocmd!
	autocmd GUIEnter * AirlineThemeDark
augroup END

set guifont=Consolas:h10:cANSI:qDRAFT
set lines=50 columns=130
