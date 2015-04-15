# Apply theme
source {$HOME}/.config/fish/agnoster.fish

# Add private bin to PATH
set -g -x PATH {$HOME}/bin $PATH

# No welcome message, please
set -g -x fish_greeting ''

# "Aliases"
#
alias lsa 'ls -Glah'

# Make vi always run vim
alias vi 'vim'

# grep in color
alias grep 'grep --color=auto'

# Brew Cask
alias cask 'brew cask'

# Find with extended regex
alias efind 'find -E'

# Launch tmux
alias tmx 'tmux new -s (hostname -s)'

# Remove newline at end of file - for those super minor changes where vi still makes a needless modification
alias chompeofnewline "perl -pi -e 'chomp if eof'"

# Show all file extensions for files in the current directory hierarchy
function fileextensions
	find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u
end
