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
* Per macOS setup:
	* Install git from (git-core/ppa repo), colordiff, source-highlight, source-highlight-solarized
	* Install [fish from ppa](https://launchpad.net/~fish-shell/+archive/ubuntu/release-2)
		* Install fisherman
		* Fisher install virtualxdriver/agnoster.fish
		* **WSL+fishv2.6BUG:** Note that fish hangs when *first run* (e.g. if `chsh -s /usr/bin/fish`) (see https://github.com/fish-shell/fish-shell/issues/4427)
			* Workaround: run `wsl.exe` with fish, then run again, then use Task Manager to kill the first process.
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
	* For other git instances, such as WSL, e.g.: `git config credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"`
		* See also https://stackoverflow.com/questions/45925964/how-to-use-git-credential-store-on-wsl-ubuntu-on-windows
		* Note: while git-credential-wincred.exe seems to work, git-credential-manager.exe doesn't seem to work

# TODO
* Merge/DRY up
	* `vdr` in fish (mac) and win10
	* `.gvimrc` in fish (mac) and win10
	* fish config
* Revisit fish+WSL workaround when fish 3.0 is released, or WSL issue is resolved?
* Resolve fzf.exe for mintty: https://github.com/junegunn/fzf/wiki/Windows#fzf-outputs-character-set-not-supported-when-term-environment-variable-is-set
* Find a place for Win scripts:
	* `printf '\e]2;%s\a' 'Windows Git Bash'`  # Which one?
		* This also works: `printf '\e]0;%s\a' 'Windows Git Bash'`
	* Put this into a PowerShell profile (usually run as Administrator): `Function arg { rg.exe --hidden --pretty --glob !.git $args | Out-Host -Paging }`
