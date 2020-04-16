"Display current whitespace option values
function! ws#Status()
	verbose set expandtab? smarttab? tabstop? shiftwidth? softtabstop?
endfunction

"Shortcut for UseSpaces(2)
function! ws#2s()
	call ws#UseSpaces(2)
endfunction

"Shortcut for UseSpaces(4)
function! ws#4s()
	call ws#UseSpaces(4)
endfunction

"New tabs and indentations will be <width> spaces
function! ws#UseSpaces(width)
	let setexpr = 'set expandtab smarttab softtabstop=0 tabstop='.a:width.' shiftwidth='.a:width
	execute setexpr
	echo 'Spaces: '.a:width

	" See plugin 'Yggdroot/indentLine'
	if exists(':IndentLinesReset') && exists('b:indentLine_enabled') && b:indentLine_enabled == 1
		IndentLinesReset
	endif
endfunction

"Use tabs that appear <width> characters long
function! ws#UseTabs(width)
	let setexpr = 'set noexpandtab softtabstop=0 tabstop='.a:width.' shiftwidth='.a:width
	execute setexpr
	echo 'Tabs: '.a:width

	" See plugin 'Yggdroot/indentLine'
	if exists(':IndentLinesReset') && exists('b:indentLine_enabled') && b:indentLine_enabled == 1
		IndentLinesReset
	endif
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

" What is the opposite of "Highlight"?
function! ws#Clear()
	call clearmatches()
endfunction