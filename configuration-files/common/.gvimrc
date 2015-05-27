colorscheme solarized

" Create preset dark and light themes. Default to light.
command AirlineThemeDark set background=dark | AirlineTheme luna
command AirlineThemeLight set background=light | AirlineTheme tomorrow
autocmd GUIEnter * AirlineThemeLight

set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h12
set transparency=7
