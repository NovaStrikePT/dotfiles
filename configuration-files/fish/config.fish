# Apply theme
source {$HOME}/.config/fish/agnoster.fish

# Add private bin to PATH
set -gx PATH {$HOME}/bin $PATH

# No welcome message, please
set -gx fish_greeting ''

# Use vi mode
#fish_vi_mode

# Set up less to use syntax highlighting (with color) and no de-init (don't clear the screen)
# source-highlight needs to be installed for syntax highlighting
set -gx LESS '-RX'
set -gx LESSOPEN "| src-hilite-lesspipe.sh %s"

# "Aliases"
#
alias lsa 'ls -Glah'

# Make vi always run vim
alias vi 'vim'

# vdr using tabpages
alias viet 'vdr -t'

# grep in color
alias grep 'grep --color=auto'

# Use colordiff whenever possible
if hash colordiff 2>/dev/null;
	alias diff 'colordiff'
end

# Brew Cask
alias cask 'brew cask'

alias cask_outdated "brew cask info (brew cask list) | fgrep -iB3 'not installed' ;or true"

alias brouhaha 'sudo chown -R (whoami) /usr/local ;and cask cleanup ;and brew cleanup ;and brew update ;and echo --brew outdated-- ;and brew outdated ;and echo --cask outdated-- ;and cask_outdated'

# Find with extended regex
alias efind 'find -E'

# Launch tmux
alias tmx 'tmux new -s (hostname -s)'

# Vagrant
alias vg 'vagrant'

# Get formatted mtime of a file
alias mtime 'stat -f "%Sm" -t "%Y-%m-%d %H.%M"'

# Remove newline at end of file - for those super minor changes where vi still makes a needless modification
alias chompeofnewline "perl -pi -e 'chomp if eof'"

# Show all file extensions for files in the current directory hierarchy
function fileextensions
	find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u
end

# Source (optional) local configuration
set -l local_config {$HOME}/.config/fish/local.fish
if test -f $local_config
	source $local_config
end
