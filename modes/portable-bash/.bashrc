#!/bin/bash
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Set directory colors
# Note: Remove ~/.dir_colors if using a terminal that already sets LS_COLORS
if [ -f "$HOME/.dir_colors" ]; then
	eval $(dircolors "$HOME/.dir_colors")
fi

# Aliases
#
alias lsa='ls -lah --color=auto'

# Use vim as default editor
export VISUAL=vim
export EDITOR="$VISUAL"
alias vi='vim'

# grep in color
alias grep='grep --color=auto'

# Show all file extensions for files in the current directory hierarchy
alias fileextensions="find . -type f | perl -ne 'print \$1 if m/\\.([^.\\/]+)$/' | sort -u"

# Use colordiff whenever possible
if hash colordiff 2>/dev/null; then
	alias diff='colordiff'
fi

# Set up less to use syntax highlighting (with color) and no de-init (don't clear the screen)
# source-highlight needs to be installed for syntax highlighting
export LESS='-RX'
if hash src-hilite-lesspipe.sh 2>/dev/null; then
	export LESSOPEN="| src-hilite-lesspipe.sh %s"
fi

# NVM configuration
export NVM_DIR="$HOME/.nvm"

# Common rsync over ssh macro
alias rsshnc='rsync -avh --progress -e ssh'

# Use ack to find files for fzf
export FZF_DEFAULT_COMMAND='ack -l ""'

# Use 16-color terminal colors by default
export FZF_DEFAULT_OPTS='--color=16'

# Git auto-completion
if [ -f "${HOME}/git-completion.bash" ]; then
	source "${HOME}/git-completion.bash"
fi

# Source (optional) local configuration
local_config="${HOME}/.bashrc.local"
if [ -f "$local_config" ]; then
	source "$local_config"
fi
