# fzf and fzf.vim don't work as-is from Git bash for Windows, so we wrap existing config with a few overrides/extras
# `PS> $ProgramFiles\Git\bin\bash.exe --init-file $HOME\git-bash-for-windows.profile`
# See also:
# * https://github.com/junegunn/fzf/issues/1093
# * https://github.com/junegunn/fzf/issues/963
# See also overrides in .bashrc.local

# Load default login profile
if [ -f "${HOME}/.bash_profile" ]; then
	source "${HOME}/.bash_profile"
fi

# Override .bashrc[.local] to use Windows-compatible configuration
# Note that Win binary fzf.exe must run in fullscreen mode
# See https://github.com/junegunn/fzf/wiki/Windows#no---height-support
export FZF_DEFAULT_COMMAND='fd.exe --type file --hidden --no-ignore-vcs --exclude .git'
export FZF_CTRL_T_COMMAND='fd.exe --hidden --no-ignore-vcs'
export FZF_CTRL_T_OPTS='--no-height'
export FZF_ALT_C_COMMAND='fd.exe --type directory --hidden --no-ignore-vcs'
export FZF_ALT_C_OPTS='--no-height'  # TODO: win32 tree.com doesn't like trailing slashes; is there a way to use it for preview?
export FZF_CTRL_R_OPTS="--no-height --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# TERM and SHELL should be empty (see https://github.com/junegunn/fzf/issues/1093)
# Launching gVim from bash uses default bash temp dirs (e.g. /tmp), but fzf.vim needs a temp location accessible by the Windows user
# (Overrides .bashrc.local)
alias viet='TERM="" SHELL="" vdr -t -c "let \$TMP=\"C:\\\\\\Users\\\\\\'$(whoami)'\\\\\\AppData\\\\\\Local\\\\\\Temp\""'
