# Setup Steps
* Add %HOME% environment variable
* Install Ubuntu WSL
	* See https://superuser.com/questions/1271682/is-there-a-way-of-installing-windows-subsystem-for-linux-on-win10-v1709-withou
	* See also https://docs.microsoft.com/en-us/windows/wsl/install-on-server
	* See also https://docs.microsoft.com/en-us/windows/wsl/faq
	* Waiting on updated WSL and offline installation for Ubuntu 18.04 (https://blogs.msdn.microsoft.com/commandline/2018/05/15/build-2018-recap/)
* Instructions for setting up home directory for user
	* `ubuntu config --default-user root`
	* `usermod --home ${newHome} ${user}`
* Install `portable-bash` first, then install `win10`
* Install gvim using [executable installer](https://www.vim.org/download.php#pc) (we use the batch files). TODO: Can we recreate the batch files for [nightly/64-bit gvim](https://github.com/vim/vim-win32-installer)?
* Install [Cmder](http://cmder.net/)
	* Add task for `fish::Ubuntu`: `"C:\Windows\System32\wsl.exe" -new_console:d%USERPROFILE% -new_console:P<Ubuntu>`
		* (Optional) change icon to %ProgramFiles%\WindowsApps\CanonicalGroupLimited.UbuntuonWindows_1604.2017.922.0_x64__79rhkp1fndgsc\images\icon.ico (need to grant access to WindowsApps directory)
	* (Optional) change icons for other tasks
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
* Additional WSL items per macOS setup:
	* Install git from (git-core/ppa repo), colordiff, source-highlight, source-highlight-solarized
	* Install [fish from ppa](https://launchpad.net/~fish-shell/+archive/ubuntu/release-2)
		* Install fisherman
		* Fisher install virtualxdriver/agnoster.fish
	* Install nvm (also requires fisher to use nvm in fish)
		* https://github.com/creationix/nvm#git-install
		* Install node.js using `nvm`
			* Install [Bass](https://github.com/edc/bass) (to be able to run nvm in fish)
				```
				fisher install edc/bass
				```
			* `mkdir ~/.nvm`
			* If node was already installed with homebrew, see http://stackoverflow.com/questions/11177954/how-do-i-completely-uninstall-node-js-and-reinstall-from-beginning-mac-os-x
			* `nvm install node` to install the latest
			* (Optional) create a .nvmrc or `nvm alias default <version>` to specify a default version to use
* `C:` mount point differs between Git bash and WSL. Create symlink in WSL for consistent behavior: `sudo ln -s /mnt/c /c`
* gitcredentials
	* Git for Windows (e.g. Git Bash) already has `credential.helper=manager`
	* For other git instances, such as WSL, e.g.: `git config credential.helper "/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"`
		* See also https://stackoverflow.com/questions/45925964/how-to-use-git-credential-store-on-wsl-ubuntu-on-windows
		* Note: while git-credential-wincred.exe seems to work, git-credential-manager.exe doesn't seem to work

# Other setup/applications
* [Gpg4win](https://gpg4win.org/thanks-for-download.html) (see also https://gnupg.org/download/)
* `Install-Module -Name Recycle`

# TODO
* Update configs accounting for cmder (e.g. $MSYSTEM detection)
* Store cmder and/or ConEmu configs?
* Merge/DRY up
	* `vdr` in fish (mac) and win10
	* `.gvimrc` in fish (mac) and win10
	* fish config
* **WSL+fishv2.6BUG:** Note that fish hangs when *first run* (e.g. if `chsh -s /usr/bin/fish`) (see https://github.com/fish-shell/fish-shell/issues/4427)
	* Workaround: run `wsl.exe` with fish, then run again, then use Task Manager to kill the first process.
	* See also https://github.com/Microsoft/WSL/issues/1653
	* And https://github.com/MicrosoftDocs/WSL/issues/191
	* Should be resolved with WSL from Windows 1803
* Revisit ConEmu AppKeys (arrow keys in vim): https://github.com/Microsoft/WSL/issues/111
	* Add to WSL task: `-new_console:p5`
* Resolve `FZF_DEFAULT_COMMAND` for git bash for Windows (should use Windows version of `rg` (e.g. use Windows version of `FZF_DEFAULT_COMMAND`))
	* `fzf` works with: `FZF_DEFAULT_COMMAND='rg --files --hidden --glob !.git . 2>nul' fzf`
	* `viet` works with `fzf-vim`: `TERM='' SHELL='' FZF_DEFAULT_COMMAND='rg --files --hidden --glob !.git . 2>nul' viet`
		* In vim, `let $TMP='C:\Users\ptran\AppData\Local\Temp'` (can't set this in environment variable?)
		* How to automatically fall back to Windows FZF_DEFAULT_COMMAND?

		```
		# Superfly aliases
		# TODO: WHAT?
		alias sffzf='FZF_DEFAULT_COMMAND="rg --files --hidden --glob !.git . 2>nul" fzf'
		alias sfviet="echo \":let \\\$TMP='C:\\Users\\ptran\\AppData\\Local\\Temp\" ; TERM='' SHELL='' FZF_DEFAULT_COMMAND='rg --files --hidden --glob !.git . 2>nul' viet"
		```
	* Maybe helpful: https://github.com/junegunn/fzf/issues/1093
* Find a place for Win scripts:
	* Term beep? https://github.com/Microsoft/WSL/issues/715#issuecomment-238010146
	* PowerShell as Administrator doesn't share network drive session, so drives need to be (re-)mapped, but persisting the network drive (H:) does weird things (can't Remove-PSDrive, PowerShell profile is no longer read). Investigate further
	* Put into PowerShell profiles
		* See also https://blogs.technet.microsoft.com/heyscriptingguy/2012/05/21/understanding-the-six-powershell-profiles/)
		* `C:\Windows\System32\WindowsPowerShell\Profile.ps1`
		* `$HOME\Documents\Profile.ps1` (GPO'd profile may be on network share)
		* `echo $profile`
		* For Cmder, put into `config/user-profile.ps1`

		```
		Set-PSReadlineOption -BellStyle None
		Set-Location $HOME  # For Administrator/GPO'd profiles
		# function arg { rg.exe --hidden --pretty --glob !.git $args | Out-Host -Paging }
		function arg { rg.exe --hidden --pretty --glob !.git $args }
		Set-Alias -Name recycle -Value Remove-ItemSafely  # cf `Find-Module -Name Recycle`
		```
* Custom Explorer folder: https://winaero.com/blog/make-explorer-open-custom-folder-instead-of-this-pc-or-quick-access-in-windows-10/
	1. Make registry keys/path: `HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{52205fd8-5dfb-447d-801a-d0b52f2e83e1}\shell\opennewwindow\command`
	1. Assign value to (Default): `wscript.exe C:\Users\<username>\explorer-launch.vbs`
	1. Create empty string value, `DelegateExecute`
