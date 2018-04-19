set guitablabel=%N.\ %M%t

colorscheme solarized

" Create preset dark and light themes. Default to light.
command AirlineThemeDark set background=dark | AirlineTheme luna
command AirlineThemeLight set background=light | AirlineTheme papercolor
augroup guiTheme
	autocmd!
	autocmd GUIEnter * AirlineThemeLight
augroup END

set guifont=Droid_Sans_Mono_Slashed_for_Pow:h9:cANSI:qDRAFT
set lines=50 columns=130
