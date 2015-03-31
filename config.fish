# Apply theme
source {$HOME}/.config/fish/agnoster.fish

# Add private bin to PATH
set -g -x PATH {$HOME}/bin $PATH

# No welcome message, please
set -g -x fish_greeting ''

# "Aliases"
function lsa
	ls -Glah $argv
end
