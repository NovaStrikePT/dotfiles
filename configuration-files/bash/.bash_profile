# Load user configuration
if [ -f "${HOME}/.bashrc" ]; then
	source "${HOME}/.bashrc"
fi

# Include private bin in $PATH
if [ -d "${HOME}/bin" ]; then
	export PATH="${PATH}:${HOME}/bin"
fi

# Include a timestamp in the history
export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S %Z] "

# Keep 5000 entries in bash history list and history file
export HISTSIZE=5000
export HISTFILESIZE=5000
