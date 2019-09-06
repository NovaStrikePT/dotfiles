set guitablabel=%N.\ %M%t

colorscheme solarized

" Create preset dark and light themes. Default to light.
command AirlineThemeDark set background=dark | AirlineTheme luna
command AirlineThemeLight set background=light | AirlineTheme papercolor
augroup guiTheme
	autocmd!
	autocmd GUIEnter * AirlineThemeDark
augroup END

set guifont=Consolas:h9:cANSI:qDRAFT
set lines=50 columns=130
