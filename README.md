## Dotfiles for OS X Yosemite
These dotfiles have only been tested on my Yosemite environments.

## Installation
1. Clone

	```
	git clone --recursive https://github.com/NovaStrikePT/dotfiles
	```

1. Install [patched Powerline fonts](https://github.com/powerline/fonts).
1. Create symlinks.
3. Install Vundle plugins.

	```
	vim +PluginInstall
	```

4. Compile Command-T.

	```
	cd ~/.vim/bundle/command-t/ruby/command-t
	ruby extconf.rb
	make
	```

5. Done.
