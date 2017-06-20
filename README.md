# Structure
* `bin-files` – miscellaneous scripts
* `configuration-files` – "dotfiles"
* `init` – scripts to assist in deployment

Within `bin-files` and `configuration-files`,

* `bash` – bash-specific files
* `fish` – fish-specific files
* `common` – files that can be deployed when using either shell

# Installation
1. Install [patched Powerline fonts](https://github.com/powerline/fonts)
1. [Create links](init/create-links)
2. (Optional) [Create ssh config](init/create-ssh-config)
1. Install [plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) into `.vim/autoload`
3. Install plugins `vim +PlugInstall`
4. Compile Command-T: https://github.com/wincent/command-t/blob/master/doc/command-t.txt#L300-L371
5. Done.
