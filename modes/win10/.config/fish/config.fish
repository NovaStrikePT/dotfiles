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
set -gx LESS '-RX'
set -gx LESSOPEN "| src-hilite-lesspipe.sh %s"

# "Aliases"
#
alias lsa 'ls -lah --color=auto'

# Make vi always run vim
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

# Remove newline at end of file - for those super minor changes where vi still makes a needless modification
alias chompeofnewline "perl -pi -e 'chomp if eof'"

# Show all file extensions for files in the current directory hierarchy
function fileextensions
	find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u
end

# Common rsync over ssh macro
alias rsshnc 'rsync -avh --progress -e ssh'

# `rg` aliases
function arg
	# See also $LESS options above
	rg --hidden --pretty --glob \!.git $argv | less
end
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob \!.git'

# Source (optional) local configuration
set -l local_config {$HOME}/.config/fish/local.fish
if test -f $local_config
	source $local_config
end
