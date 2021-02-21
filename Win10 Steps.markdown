# Setup Steps
1. Add user `HOME` environment variable = `%UserProfile%`
1. Install Ubuntu WSL (18.04)
	* See https://docs.microsoft.com/en-us/windows/wsl/install-on-server
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
	* [fish from ppa](https://launchpad.net/~fish-shell)
		```
		sudo apt update
		sudo apt install fish
		chsh -s /usr/bin/fish
		```
	* sudo apt install colordiff source-highlight tree
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
1. Install plug.vim, plugins
	```
	curl -Lo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall
	```
1. Install PowerShell Core and add to `%PATH%`
1. Install posh-git
	```PowerShell
	# TODO: Prerelease for 1.0beta currently; revisit if we need prerelease after 1.0 is stable
	Install-Module posh-git -AllowPrerelease -Force
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
1. `C:` mount point differs between Git bash and WSL. Create symlink in WSL for consistent behavior: `sudo ln -s /mnt/c /c`
1. gitcredentials
	* NEW: Keep an eye on https://github.com/microsoft/Git-Credential-Manager-Core for Linux support
	* Git for Windows (e.g. Git Bash) already has `credential.helper=manager`
	* For WSL: `git config credential.helper "/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"`
		* See also https://stackoverflow.com/questions/45925964/how-to-use-git-credential-store-on-wsl-ubuntu-on-windows
		* Note: while git-credential-wincred.exe seems to work, git-credential-manager.exe doesn't seem to work.
		* Note: This creates a credential configuration *per repo*. We really want a separate credential configuration *per environment*.
		* Note: Git Credential Manager for Windows does not distinguish two accounts for the same domain (i.e. can't separately use credentials for two GitHub.com accounts). If most repositories use one GitHub account, we can use a local `credential.useHttpPath = true` for individual repos that require different account credentials.
			* See also microsoft/Git-Credential-Manager-for-Windows issue 749

# Other setup/applications
* [Gpg4win](https://gpg4win.org/thanks-for-download.html) (see also https://gnupg.org/download/)
* `Install-Module -Name Recycle`

# TODO

## Use script to set environment variables
```
PS> [Environment]::SetEnvironmentVariable("MY_VAR", "My Value", "Machine"|"User")
```

## Symbolic links
* Generate all symbolic links using Windows symlinks

	```PowerShell
    Set-Location modes\win10
    Get-ChildItem -Directory -Recurse | Resolve-Path -Relative | ForEach-Object { New-Item -ItemType Directory -Path (Join-Path -Path $HOME -ChildPath "temp" -AdditionalChildPath $_) | Select-Object FullName, Attributes }
    Get-ChildItem -File -Recurse | ForEach-Object { New-Item -ItemType SymbolicLink -Target $_.FullName -Path (Join-Path -Path $HOME -ChildPath "temp" -AdditionalChildPath (Resolve-Path -Relative -Path $_)) | Select-Object LinkType,Target }
	```

## Merge/DRY up
* `vdr` in fish (mac) and win10
* `.gvimrc` in fish (mac) and win10
* fish config
* Rename `local-fish` to `mac-fish` (or something to distinguish deployment OS/environment)

## Environments
* Git credential configuration per environment
* Is there a better way to differentiate WSL and Git bash environments (better than $MSYSTEM detection?)
