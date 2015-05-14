"Display current whitespace option values
function! whitespace#Status()
	verbose set expandtab? smarttab? tabstop? shiftwidth? softtabstop?
endfunction

"New tabs and indentations will be 8 spaces
function! whitespace#UseSpaces()
	set expandtab smarttab tabstop=8 shiftwidth=8 softtabstop=0
        call whitespace#Status()
endfunction

"Use tabs that appear 8 characters long
function! whitespace#UseTabs()
	set noexpandtab tabstop=8 shiftwidth=8 softtabstop=0
        call whitespace#Status()
endfunction

"Convert tabs to spaces
function! whitespace#ConvertToSpaces()
	call whitespace#UseSpaces()
	retab
endfunction

"Convert spaces to tabs
function! whitespace#ConvertToTabs()
	call whitespace#UseTabs()
	retab!
endfunction

" Show whitespace
" Tabs: -->
" Trailing: .
" Extended lines: < and >
" EOL: $
function! whitespace#Show()
	set list listchars=tab:>-,trail:.,precedes:<,extends:>,eol:$
endfunction

" Show whitespace
function! whitespace#Hide()
	set nolist
endfunction

"Highlight whitespace
function! whitespace#Highlight()
	highlight WSMatchGroupInfo ctermbg=green guibg=green
	highlight WSMatchGroupCaution ctermbg=yellow guibg=yellow
	highlight WSMatchGroupWarning ctermbg=red guibg=red

	" Spaces at the start of a line (space-indented)
	call matchadd("WSMatchGroupInfo", '^\t*\zs \+')

	"Tabs not at the start of a line
	call matchadd("WSMatchGroupCaution", '[^\t]\zs\t\+')

	"Trailing whitespace and spaces before a tab
	call matchadd("WSMatchGroupWarning", '\s\+$\| \+\ze\t')
endfunction
