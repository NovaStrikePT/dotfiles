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


# Colors
#

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

# Git prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
#GIT_PS1_SHOWCOLORHINTS=1
if [ -f "${HOME}/git-prompt.sh" ]; then
	source "${HOME}/git-prompt.sh"
fi

PS1="\n\[$Cyan\]\h:\[$Green\]\u\n\[$Blue\]\w\[$Yellow\]\$(__git_ps1)\[$Color_Off\] \\$ "

# Git auto-completion
if [ -f "${HOME}/git-completion.bash" ]; then
	source "${HOME}/git-completion.bash"
fi

# Source (optional) local configuration
local_config="${HOME}/.bashrc.local"
if [ -f "$local_config" ]; then
	source "$local_config"
fi
