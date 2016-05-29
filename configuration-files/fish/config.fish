# Apply theme
source {$HOME}/.config/fish/agnoster.fish

# Add private bin to PATH
set -gx PATH {$HOME}/bin $PATH

# No welcome message, please
set -gx fish_greeting ''

# NVM configuration
set -gx NVM_DIR $HOME/.nvm

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

function brouhaha
	sudo chown -R (whoami) /usr/local
	cask cleanup ;and brew cleanup
	brew update
	echo -n '==> ' ; set_color --bold '#819090' ; echo brew outdated ; set_color normal
	brew outdated
	echo -n '==> ' ; set_color --bold '#819090' ; echo cask outdated ; set_color normal
	cask_outdated ;
	echo -n '==> ' ; set_color --bold '#819090' ; echo 'Reminder(s)' ; set_color normal
	echo Don\'t forget to run `fisher up`
end

# Find with extended regex
alias efind 'find -E'

# Launch tmux
#alias tmx 'tmux new -s (hostname -s)'

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

# Common rsync over ssh macro
alias rsshnc 'rsync -avh --progress -e ssh'

# Running NVM in fish is easy with bass
function nvm
	bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

# Common grepper macros
#
# Laravel grepper
function lvg --argument-names 'search_string' 'search_path'
	grepper "$search_string" 'php' -x '.git|.vagrant|node_modules|vendor' "$search_path"
end
# Ember grepper
function emg --argument-names 'search_string' 'search_path'
	grepper "$search_string" 'js|hbs' -x '.git|tmp|node_modules|bower_components|vendor|dist' "$search_path"
end

# Source (optional) local configuration
set -l local_config {$HOME}/.config/fish/local.fish
if test -f $local_config
	source $local_config
end
