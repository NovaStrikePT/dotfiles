# Structure
* `bin-files` – miscellaneous scripts
* `configuration-files` – "dotfiles"
* `init` – scripts to assist in deployment

Within `bin-files` and `configuration-files`,

* `bash` – bash-specific files
* `fish` – fish-specific files
* `common` – files that can be deployed when using either shell

# Installation
1. Clone

	```
	git clone --recursive https://github.com/NovaStrikePT/dotfiles
	```

	If cloned without the recursive option,

	```
	git submodule update --init --recursive
	```
1. Install [patched Powerline fonts](https://github.com/powerline/fonts).
1. [Create links](init/create-links).
2. (Optional) [Create ssh config](init/create-ssh-config).
3. Install Vundle plugins.

	```
	vim +PluginInstall
	```
4. Compile Command-T (requires Ruby and Vim compiled with Ruby support).

	```
	cd ~/.vim/bundle/command-t/ruby/command-t
	ruby extconf.rb
	make
	```
5. Done.
