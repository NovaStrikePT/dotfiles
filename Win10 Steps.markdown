# Setup Steps
1. Add user `HOME` environment variable = `%UserProfile%`
1. Install Ubuntu WSL (18.04)
	* For enterprise-managed on versions < 1803
		* See https://superuser.com/questions/1271682/is-there-a-way-of-installing-windows-subsystem-for-linux-on-win10-v1709-withou
		* See also https://docs.microsoft.com/en-us/windows/wsl/install-on-server
		* See also https://docs.microsoft.com/en-us/windows/wsl/faq
		* Waiting on updated WSL and offline installation for Ubuntu 18.04 (https://blogs.msdn.microsoft.com/commandline/2018/05/15/build-2018-recap/)
	1. Enable Windows Subsystem for Linux (via Turn Windows features on or off)
	1. Download via Store or appx
		* If used appx, to move windows installation, see registry keys in `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss`
			* Source: https://github.com/Microsoft/WSL/issues/3324
	1. Run the Ubuntu app for initial installation
	1. Update Ubuntu
		```
		PS> wsl.exe

		$ sudo apt update
		$ sudo apt dist-upgrade
		$ logout
		```
	1. Set user home directory
		* Note that WSLENV only works on Windows release ≥ 1803
		```
		PS> ubuntu[1804].exe config --default-user root
		PS> & { $previous = $Env:WSLENV ; $Env:WSLENV = $Env:WSLENV + ":USERPROFILE/up" ; wsl.exe ; if ($previous) { $Env:WSLENV = $previous } else { Remove-Item Env:\WSLENV } }

		$ usermod --home $USERPROFILE <username>
		$ logout

		PS> ubuntu[1804].exe config --default-user <username>
		```
1. Install other items in WSL
	* [git from ppa](https://launchpad.net/~git-core/+archive/ubuntu/ppa)
	* [fish from ppa](https://launchpad.net/~fish-shell/+archive/ubuntu/release-2)
		```
		sudo apt update
		sudo apt install fish
		chsh -s /usr/bin/fish
		```
	* Install [fisher](https://github.com/jorgebucaran/fisher)
		1. Use a customized version of `oh-my-fish/theme-agnoster`

			```shell
			git clone https://github.com/oh-my-fish/theme-agnoster ~/Projects/vendor/oh-my-fish/theme-agnoster
			cd ~/Projects/vendor/oh-my-fish/theme-agnoster/
			git co -b wsl-agnoster-ignore
			```
		1. Then edit the `prompt_git` function, in `~/Projects/vendor/oh-my-fish/theme-agnoster/fish_prompt.fish`, to check for a wsl-agnoster-ignore file

			```shell
			function prompt_git -d "Display the actual git state"
				set -l ref
				set -l dirty
				if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
					# Modification from Agnoster
					# Ignore git parsing for repos that contain a .wsl-agnoster-ignore file
					if test -f (command git rev-parse --show-toplevel)/.wsl-agnoster-ignore
						prompt_segment magenta black "wsl-agnoster-ignore"
					else
						set dirty (parse_git_dirty)
						set ref (command git symbolic-ref HEAD 2> /dev/null)
						if [ $status -gt 0 ]
							set -l branch (command git show-ref --head -s --abbrev |head -n1 2> /dev/null)
							set ref "➦ $branch "
						end
						set branch_symbol \uE0A0
						set -l branch (echo $ref | sed  "s-refs/heads/-$branch_symbol -")
						if [ "$dirty" != "" ]
							prompt_segment yellow black "$branch $dirty"
						else
							prompt_segment green black "$branch $dirty"
						end
					end
				end
			end
			```
		1. Finally, `fisher add ~/Projects/vendor/oh-my-fish/theme-agnoster`
	* sudo apt install colordiff source-highlight tree
	* [source-highlight-solarized](https://github.com/jrunning/source-highlight-solarized)
		1. Download / clone repo
		1. Find existing datadir (try `source-highlight-settings` or see `~/.source-highlight/source-highlight.conf`)
		1. Symlink everything from existing datadir into `$HOME/.source-highlight/datadir`
			```
			cd $HOME/.source-highlight
			ln -s /usr/share/source-highlight source-highlight-core
			mkdir -p datadir && cd datadir
			for f in ../source-highlight-core/*.* ; do
				ln -sf $f ./
			done
			```
		1. Symlink `esc-solarized.outlang`, `esc-solarized.style`, and `ruby.lang` into datadir (overwriting default files)
			```
			ln -sf esc-solarized.outlang esc.outlang
			ln -sf esc-solarized.style esc.style
			ln -sf extras/ruby.lang ruby.lang
			```
		1. Update source-highlight-settings _datadir_
	* nvm (also requires fisher to use nvm in fish)
		* https://github.com/creationix/nvm#git-install
		* Install node.js using `nvm`
			* Install [Bass](https://github.com/edc/bass) (to be able to run nvm in fish)
				```
				fisher install edc/bass
				```
			* `mkdir ~/.nvm`
			* `nvm install node` to install the latest
			* (Optional) create a .nvmrc or `nvm alias default <version>` to specify a default version to use
1. Install [patched Powerline fonts](https://github.com/powerline/fonts) in both Win32/64 and WSL
	* WSL: `sudo apt install fonts-powerline`
	* Win: `PS> install.ps1`
		* May need to change execution policy. As Administrator, `PS> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine`
	* Configure terminals (emulators) to use fonts
1. `create-links portable-bash -i` first, then `create-links win10 -i`
	* Some symlinks need to be created in Windows (Windows symlinks) so that Windows programs can read them (e.g. Git for Windows, gVim)
		* E.g. (PowerShell as Administrator)
			```
			PS> New-Item -ItemType SymbolicLink -Force -Name ~\.gitconfig.local -Target $HOME\Projects\dotfiles\modes\win10\.gitconfig.local
			```
		* ~~Note that https://github.com/Microsoft/WSL/issues/353 indicates this is no longer required in Windows 1803~~
		* Vim configuration files (for gVim)
		* Git config files
		* Most bash configuration files (used by Git bash for Windows)
		* gVim uses *vimfiles*: `PS> New-Item -ItemType SymbolicLink -Target $HOME\.vim -Path $HOME\vimfiles`
		* PowerShell scripts: `New-Item -ItemType SymbolicLink -Target $HOME\bin\Windows\profiles\AllUsersAllHosts.ps1 -Path $Profile.AllUsersAllHosts`
1. Install plug.vim, plugins
	```
	curl -Lo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall
	```
1. Add to %PATH%: `%UserProfile%\bin\Windows`
1. Install [gvim](https://www.vim.org/download.php#pc)
1. Install [rg](https://github.com/BurntSushi/ripgrep#installation) in Windows and WSL.
	* Ubuntu WSL: .deb file
	* Windows
		* Move/link `.exe` into a %Path% location
1. Install [fd](https://github.com/sharkdp/fd/releases)
	* Ubuntu WSL: .deb file
	* Windows
		* Move/link `.exe` into a %Path% location
1. Download [fzf.exe for Windows](https://github.com/junegunn/fzf-bin/releases) and install/link into a %Path% location
	* Needs to exist at `$HOME\.fzf\bin\fzf.exe` for gVim
	* Create **System** environment variable: FZF_DEFAULT_COMMAND='fd.exe --type file --hidden --no-ignore-vcs --exclude .git 2>nul'
1. [Cmder mini](https://github.com/cmderdev/cmder/releases) shared install
	* Set env:`CMDER_ROOT` to install location
	* Set env:`CMDER_USER_CONFIG` (e.g. `$HOME\.cmder\config`) (this is used by `%CMDER_ROOT%\vendor\profile.ps1`)
	* (If needed) re-launch any Cmder, VS Code to get the new environment variables
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

# TODO

## Use script to set environment variables
```
PS> [Environment]::SetEnvironmentVariable("MY_VAR", "My Value", "Machine"|"User")
```

## Store apps on GPO'd machines
* [EarTrumpet .appx/installer?](https://github.com/File-New-Project/EarTrumpet/issues/204)

## Symbolic links
* Generate all symbolic links using Windows symlinks

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
* Cmder (1.3.11) and PowerShell core (6.1) color issue: https://github.com/cmderdev/cmder/issues/1899
* Store cmder and/or ConEmu configs?

## Environments
* Git credential configuration per environment
* Is there a better way to differentiate WSL and Git bash environments (better than $MSYSTEM detection?)
