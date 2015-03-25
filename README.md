## Dotfiles for OS X Yosemite
These dotfiles have only been tested on my Yosemite environments.

## After cloning

1. Create symlinks
2. Init submodules

	```
	#Vundle.vim
	cd .vim/bundle/Vundle.vim/
	git submodule init
	git submodule update
	```
3. Install Vundle plugins

	```
	vim +PluginInstall +qall
	```
4. Compile Command-T

	```
	cd ~/.vim/bundle/command-t/ruby/command-t
	ruby extconf.rb
	make
	```
5. Done.