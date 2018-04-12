* Instructions for seting up home directory for user
	* `ubuntu config --default-user root`
	* `usermod --home ${newHome} ${user}`
* Copy from portable-bash
* Link from local-fish
	* .gvimrc
	* .gitconfig.local
	* .nvmrc?
* Per https://github.com/Microsoft/WSL/issues/353, some symlinks need to be created in Windows so that Windows programs can read them (e.g. Git for Windows, gVim)
	* E.g. `New-Item -ItemType SymbolicLink -Force -Name .gitconfig.local -Target .\Projects\dotfiles\modes\local-fish\.gitconfig.local`
	* .vimrc
	* .gvimrc
	* .gitconfig
	* .gitconfig.local
	* .vim\
		* colors\wombat.vim
		* doc\matchit.txt
		* plugin\matchit.vim
		* plugin\ws.vim
