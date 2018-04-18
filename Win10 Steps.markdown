# Setup Steps
* Add %HOME% environment variable
* Instructions for setting up home directory for user
	* `ubuntu config --default-user root`
	* `usermod --home ${newHome} ${user}`
* Install `portable-bash` first, then install `win10`
* Install gvim using [executable installer](https://www.vim.org/download.php#pc) (we use the batch files). TODO: Can we recreate the batch files for [nightly/64-bit gvim](https://github.com/vim/vim-win32-installer)?
* Per https://github.com/Microsoft/WSL/issues/353, some symlinks need to be created in Windows so that Windows programs can read them (e.g. Git for Windows, gVim)
	* E.g. in PowerShell: `New-Item -ItemType SymbolicLink -Force -Name ~\.gitconfig.local -Target ~\Projects\dotfiles\modes\win10\.gitconfig.local`
	* .vimrc
	* .gvimrc
	* .gitconfig
	* .gitconfig.local
	* .vim\
		* colors\wombat.vim
		* doc\matchit.txt
		* plugin\matchit.vim
		* plugin\ws.vim
	* -Name ~\vimfiles -Target ~\.vim  # gVim uses vimfiles
	* .minttyrc
* Install [rg](https://github.com/BurntSushi/ripgrep#installation) in Windows and WSL ().
	* Ubuntu WSL: Use .deb file, at least as long as `snap` doesn't work.
	* Windows
		* Install into %Path% location (e.g. `%HOME%\AppData\Local\Microsoft\WindowsApps\`)
		* Create **System** environment variable: FZF_DEFAULT_COMMAND='rg --files --hidden --glob !.git . 2>nul'
* Download fzf.exe for Windows from https://github.com/junegunn/fzf-bin/releases and install into %Path% location (e.g. `%HOME%\AppData\Local\Microsoft\WindowsApps\`)
* (Per macOS setup) install git from (git-core/ppa repo), colordiff, source-highlight, source-highlight-solarized
* Set solarized terminal colors
	* Create shortcut to C:\Windows\System32\bash.exe (named Ubuntu Solarized, e.g.)
		* Set Start directory to %HOME%
		* (Optional) change icon to %ProgramFiles%\WindowsApps\CanonicalGroupLimited.UbuntuonWindows_1604.2017.922.0_x64__79rhkp1fndgsc\images\icon.ico (need to grant access to WindowsApps directory)
	* Set solarized colors manually on links (follow .minttyrc color scheme) (TODO: PowerShell this):
		* bash (above)
		* PowerShell
		* Developer Command Prompt for VS
		* etc.
* gitcredentials
	* Git for Windows (e.g. Git Bash) already has `credential.helper=manager`

# TODO
* Merge/DRY up
	* `vdr` in fish (mac) and win10
	* `.gvimrc` in fish (mac) and win10
* Resolve fzf.exe for mintty: https://github.com/junegunn/fzf/wiki/Windows#fzf-outputs-character-set-not-supported-when-term-environment-variable-is-set
