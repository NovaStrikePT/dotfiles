## Dotfiles for OS X Yosemite
These dotfiles have only been tested on my Yosemite environments.

## After cloning

1. Install [patched Powerline fonts](https://github.com/powerline/fonts).
1. Create symlinks.
2. Init submodules.

	```
	#Antigen
	cd antigen
	git submodule init
	git submodule update
	
	#Vundle.vim
	cd .vim/bundle/Vundle.vim/
	git submodule init
	git submodule update
	```
3. Install Vundle plugins.

	```
	vim +PluginInstall +qall
	```
4. Compile Command-T.

	```
	cd ~/.vim/bundle/command-t/ruby/command-t
	ruby extconf.rb
	make
	```
5. Done.