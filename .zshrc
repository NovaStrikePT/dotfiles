source "${HOME}/antigen/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

#antigen bundle
 #brew
 #brew-cask
 #dircycle
 #git
 #gitfast
 #git-extras
 #jsontools #Need node? Or python ok
 #npm #if I use node
 #osx
 #tmux
 #tmuxinator?
 #urltools
 #vagrant
 #vi-mode
 #wd

# Syntax highlighting bundle.
#antigen bundle zsh-users/zsh-completions
#antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme agnoster

# Tell antigen that you're done.
antigen apply
