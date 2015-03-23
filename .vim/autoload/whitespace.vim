"Display current whitespace option values
function! whitespace#Status()
	set expandtab? smarttab? tabstop? shiftwidth? softtabstop?
endfunction

"New tabs and indentations will be 8 spaces
function! whitespace#UseSpaces()
	set expandtab smarttab tabstop=8 shiftwidth=8 softtabstop=0 
endfunction

"Use tabs that appear 8 characters long
function! whitespace#UseTabs()
	set noexpandtab tabstop=8 shiftwidth=8 softtabstop=0
endfunction

"Convert tabs to spaces
function! whitespace#ConvertToSpaces()
	call WSUseSpaces()
	retab
endfunction

"Convert spaces to tabs
function! whitespace#ConvertToTabs()
	call WSUseTabs()
	retab!
endfunction
