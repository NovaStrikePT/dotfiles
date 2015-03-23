"Display current whitespace option values
function! WSStatus()
	set expandtab? smarttab? tabstop? shiftwidth? softtabstop?
endfunction

"New tabs and indentations will be 8 spaces
function! WSUseSpaces()
	set expandtab smarttab tabstop=8 shiftwidth=8 softtabstop=0 
endfunction

"Use tabs that appear 8 characters long
function! WSUseTabs()
	set noexpandtab tabstop=8 shiftwidth=8 softtabstop=0
endfunction

"Convert tabs to spaces
function! WSConvertToSpaces()
	call WSUseSpaces()
	retab
endfunction

"Convert spaces to tabs
function! WSConvertToTabs()
	call WSUseTabs()
	retab!
endfunction
