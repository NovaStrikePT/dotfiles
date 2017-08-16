set guitablabel=%N.\ %M%t

colorscheme solarized

" Create preset dark and light themes. Default to light.
command AirlineThemeDark set background=dark | AirlineTheme luna
command AirlineThemeLight set background=light | AirlineTheme papercolor
autocmd GUIEnter * AirlineThemeLight

set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h12
set transparency=4

" Specify FZF external terminal emulator
let g:fzf_launcher = "fzf-iterm-launcher %s"
