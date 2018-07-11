# Add private bin to PATH
set -gx PATH {$HOME}/bin $PATH

# No welcome message, please
set -gx fish_greeting ''

# Set default user for Agnoster theme
set -gx default_user (whoami)

# NVM configuration
set -gx NVM_DIR $HOME/.nvm

# Set up less to use syntax highlighting (with color) and no de-init (don't clear the screen)
# source-highlight needs to be installed for syntax highlighting
set -gx LESS '--RAW-CONTROL-CHARS --quit-if-one-screen --no-init' # Alternatively, `-RFX`
set -gx LESSOPEN "| src-hilite-lesspipe.sh %s"

# "Aliases"
#
alias lsa 'ls -lah --color=auto'

# Use vim as default editor
set -gx VISUAL 'vim'
set -gx EDITOR "$VISUAL"
alias vi 'vim'

# vdr using tabpages
alias viet 'vdr -t'

# grep in color
alias grep 'grep --color=auto'

# Use colordiff whenever possible
if type -q colordiff 2>/dev/null;
	alias diff 'colordiff'
end

# Find with extended regex
alias efind 'find -regextype posix-extended'

# Get formatted mtime of a file
alias mtime 'stat -f "%Sm" -t "%Y-%m-%d %H.%M"'

# WSL interacting with Windows: set TMPDIR to a Windows-accessible location
# This is primarily used only for git diff/merge GUI tools
# See https://www.sep.com/sep-blog/2017/06/07/20170607wsl-git-and-beyond-compare/
alias gitwsl "env TMPDIR=$HOME/AppData/Local/Temp/ git"

# Remove newline at end of file - for those super minor changes where vi still makes a needless modification
alias chompeofnewline "perl -pi -e 'chomp if eof'"

# Show all file extensions for files in the current directory hierarchy
function fileextensions
	fd --type file | awk --field-separator . '{print $NF}' | sort | uniq --count | awk '{print $2,$1}'
end

# Common rsync over ssh macro
alias rsshnc 'rsync -avh --progress -e ssh'

# Running NVM in fish is easy with bass
function nvm
	bass source $HOME/.nvm/nvm.sh --no-use ';' nvm $argv
end

# FZF configuration
#

set -gx FZF_DEFAULT_COMMAND 'fd --type file --hidden --exclude .git'

# Use 16-color terminal colors by default
set -gx FZF_DEFAULT_OPTS "--color=16"

# Search everything for command-line pasting (CTRL+T)
set -gx FZF_CTRL_T_COMMAND 'fd --hidden'

# Search all directories for `cd`-ing to (ALT+C)
# Provide a `tree` preview
set -gx FZF_ALT_C_COMMAND 'fd --type directory --hidden'
set -gx FZF_ALT_C_OPTS "--preview 'tree -C {} | head -100'"

# Use `?` to toggle preview window for history commands (useful for longer commands)
set -gx FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# `rg` aliases
function arg
	# See also $LESS options above
	rg --hidden --pretty --smart-case --glob \!.git $argv | less
end

# Source (optional) local configuration
set -l local_config {$HOME}/.config/fish/local.fish
if test -f $local_config
	source $local_config
end
