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
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob !.git . 2>nul'

# TERM and SHELL should be empty (see https://github.com/junegunn/fzf/issues/1093)
# Launching gVim from bash uses default bash temp dirs (e.g. /tmp), but fzf.vim needs a temp location accessible by the Windows user
# (Overrides .bashrc.local)
alias viet='TERM="" SHELL="" vdr -t -c "let \$TMP=\"C:\\\\\\Users\\\\\\'$(whoami)'\\\\\\AppData\\\\\\Local\\\\\\Temp\""'
