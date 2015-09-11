"Display current whitespace option values
function! ws#Status()
	verbose set expandtab? smarttab? tabstop? shiftwidth? softtabstop?
endfunction

"New tabs and indentations will be <width> spaces
function! ws#UseSpaces(width)
	let setexpr = 'set expandtab smarttab softtabstop=0 tabstop='.a:width.' shiftwidth='.a:width
	execute setexpr
	echo 'Spaces: '.a:width
endfunction

"Use tabs that appear <width> characters long
function! ws#UseTabs(width)
	let setexpr = 'set noexpandtab softtabstop=0 tabstop='.a:width.' shiftwidth='.a:width
	execute setexpr
	echo 'Tabs: '.a:width
endfunction

"Convert tabs to spaces (using a <width> tabstop)
function! ws#ConvertToSpaces(width)
	call ws#UseSpaces(a:width)
	retab
endfunction

"Convert spaces to tabs (using a <width> tabstop)
function! ws#ConvertToTabs(width)
	call ws#UseTabs(a:width)
	retab!
endfunction

" Show whitespace
" Tabs: -->
" Trailing: .
" Extended lines: < and >
" EOL: $
function! ws#Show()
	set list listchars=tab:>-,trail:.,precedes:<,extends:>,eol:$
endfunction

" Show whitespace
function! ws#Hide()
	set nolist
endfunction

"Highlight whitespace
function! ws#Highlight()
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
