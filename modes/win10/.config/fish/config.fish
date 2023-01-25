# Add private bin to PATH
set -gx PATH {$HOME}/bin $PATH

# No welcome message, please
set -gx fish_greeting ''

# Set up less to use syntax highlighting (with color) and no de-init (don't clear the screen)
# source-highlight needs to be installed for syntax highlighting
set -gx LESS '--RAW-CONTROL-CHARS --quit-if-one-screen --no-init' # Alternatively, `-RFX`
set -gx LESSOPEN "| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

# Use vim as default editor
set -gx VISUAL 'vim'
set -gx EDITOR "$VISUAL"

#region Aliases/abbreviations

abbr lsa --add ls -lah --color=auto

# Single-depth du
abbr --add du1 du -h --max-depth=1

# Use colordiff whenever possible
if type -q colordiff 2>/dev/null;
	alias diff 'colordiff'
end

# `rg` commonly used preset
function arg
	# See also $LESS options above
	rg --hidden --pretty --smart-case --no-ignore-vcs --glob \!.git $argv | less
end

# Show all file extensions for files in the current directory hierarchy
function fileextensions
	fd --type file --no-ignore-vcs | awk --field-separator . '{print $NF}' | sort | uniq --count | awk '{print $2,$1}'
end

#endregion

# Use this file-discovery command for `fzf` by default
set -gx FZF_DEFAULT_COMMAND 'fd --type file --hidden --no-ignore-vcs --exclude .git'

# Source additional local configuration file, if it exists
set -l local_config {$HOME}/.config/fish/local.fish
if test -f $local_config
	source $local_config
end
