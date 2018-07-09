# Setup Steps
1. Add user `HOME` environment variable = `%UserProfile%`
1. Install Ubuntu WSL
	* For enterprise-managed on versions < 1803
		* See https://superuser.com/questions/1271682/is-there-a-way-of-installing-windows-subsystem-for-linux-on-win10-v1709-withou
		* See also https://docs.microsoft.com/en-us/windows/wsl/install-on-server
		* See also https://docs.microsoft.com/en-us/windows/wsl/faq
		* Waiting on updated WSL and offline installation for Ubuntu 18.04 (https://blogs.msdn.microsoft.com/commandline/2018/05/15/build-2018-recap/)
1. Instructions for setting up home directory for user
	* TODO: Clarify steps
	* `ubuntu.exe config --default-user root`
	* `usermod --home ${newHome} ${user}`
1. Install other items in WSL
	* [git from ppa](https://launchpad.net/~git-core/+archive/ubuntu/ppa)
	* [fish from ppa](https://launchpad.net/~fish-shell/+archive/ubuntu/release-2)
		* Install fisherman
		* `fisher install virtualxdriver/agnoster.fish`
	* colordiff, source-highlight, source-highlight-solarized
	* nvm (also requires fisher to use nvm in fish)
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
1. Install [patched Powerline fonts](https://github.com/powerline/fonts) in both Win32/64 and WSL
	* WSL: `install.sh`
	* Win: `PS> install.ps1`
1. `create-links portable-bash` first, then `create-links win10 -f`
	* Some symlinks need to be created in Windows (Windows symlinks) so that Windows programs can read them (e.g. Git for Windows, gVim)
		* E.g. (PowerShell as Administrator)
			```
			PS> New-Item -ItemType SymbolicLink -Force -Name ~\.gitconfig.local -Target $HOME\Projects\dotfiles\modes\win10\.gitconfig.local
			```
		* Note that https://github.com/Microsoft/WSL/issues/353 indicates this is no longer required in Windows 1803
		* Vim configuration files (for gVim)
		* Git config files
		* Most bash configuration files (used by Git bash for Windows)
		* gVim uses *vimfiles*: `PS> New-Item -ItemType SymbolicLink -Target $HOME\.vim -Path $HOME\vimfiles`
		* PowerShell scripts (`~\bin\Windows\**`)
1. [Cmder mini](https://github.com/cmderdev/cmder/releases) shared install
	* Set env:`CMDER_ROOT` to install location
	* Set env:`CMDER_USER_CONFIG` (e.g. `$HOME\.cmder\config`)
	* Modify `bash::bash` tasks to use Git for Windows installation: `%ProgramFiles%\Git\bin\bash.exe --init-file %UserProfile%\git-bash-for-windows.profile`
	* Add a task for `fish::Ubuntu`: `%SystemRoot%\System32\wsl.exe -new_console:p5 -new_console:d%USERPROFILE%`
		* Arrow keys issues:
			* https://github.com/Microsoft/WSL/issues/111
			* https://github.com/Maximus5/ConEmu/issues/629
	* Source PowerShell profile in the Cmder user-profile:
		* Note: If `$Env:CMDER_USER_CONFIG/user-profile.ps1` doesn't exist, run a Cmder PowerShell profile to auto-generate the user-profile on first run.
		* `PS> Add-Content -Path $Env:CMDER_USER_CONFIG\user-profile.ps1 -Value '. $HOME\bin\Windows\profiles\AllUsersAllHosts.ps1'`
	* Shortcut target: `%CMDER_ROOT%\Cmder.exe /C %UserProfile%\.cmder`
	* (Optional) change icons for tasks
	* See also https://blogs.technet.microsoft.com/heyscriptingguy/2012/05/21/understanding-the-six-powershell-profiles/)
		* `$PROFILE | Format-List * -Force`
1. Install [gvim](https://www.vim.org/download.php#pc)
1. Install [rg](https://github.com/BurntSushi/ripgrep#installation) in Windows and WSL.
	* Ubuntu WSL: Use .deb file, at least as long as `snap` doesn't work.
	* Windows
		* Move/link `rg.exe` into a %Path% location
1. [fd.exe](https://github.com/sharkdp/fd/releases)
1. Download [fzf.exe for Windows](https://github.com/junegunn/fzf-bin/releases) and install/link into a %Path% location
		* Create **System** environment variable: FZF_DEFAULT_COMMAND='fd.exe --type file --hidden --exclude .git 2>nul'
1. `C:` mount point differs between Git bash and WSL. Create symlink in WSL for consistent behavior: `sudo ln -s /mnt/c /c`
1. gitcredentials
	* Git for Windows (e.g. Git Bash) already has `credential.helper=manager`
	* For WSL: `git config credential.helper "/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"`
		* See also https://stackoverflow.com/questions/45925964/how-to-use-git-credential-store-on-wsl-ubuntu-on-windows
		* Note: while git-credential-wincred.exe seems to work, git-credential-manager.exe doesn't seem to work.
		* Note: This creates a credential configuration *per repo*. We really want a separate credential configuration *per environment*.

# Other setup/applications
* [Gpg4win](https://gpg4win.org/thanks-for-download.html) (see also https://gnupg.org/download/)
* `Install-Module -Name Recycle`
* Foobar2000
	* foo_seek
	* foo_youtube

# TODO

## Store apps on GPO'd machines
* [EarTrumpet .appx/installer?](https://github.com/File-New-Project/EarTrumpet/issues/204)

## Symbolic links
* Generate all symbolic links using Windows symlinks. Or just upgrade to Windows 1803 (https://github.com/Microsoft/WSL/issues/353#event-1645479412)

## Merge/DRY up
* `vdr` in fish (mac) and win10
* `.gvimrc` in fish (mac) and win10
* fish config
* Rename `local-fish` to `mac-fish` (or something to distinguish deployment OS/environment)

## WSL+fishv2.6BUG
* Note that fish hangs when *first run* (e.g. if `chsh -s /usr/bin/fish`) (see https://github.com/fish-shell/fish-shell/issues/4427)
	* Workaround: run `wsl.exe` with fish, then run again, then use Task Manager to kill the first process.
	* See also https://github.com/Microsoft/WSL/issues/1653
	* And https://github.com/MicrosoftDocs/WSL/issues/191
	* Should be resolved with WSL from Windows 1803

## VS Code
* VS Code use environment vars in settings.json: https://github.com/Microsoft/vscode/issues/2809
	* Once that is resolved, we can use `CMDER_ROOT` to locate the Cmder profile

## Cmder
* Store cmder and/or ConEmu configs?

## Environments
* Git credential configuration per environment
* Is there a better way to differentiate WSL and Git bash environments (better than $MSYSTEM detection?)