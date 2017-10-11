# Dotfiles

## Modes
* `local-fish` for my local machines running fish (tested on macOS)
* `portable-bash` for remote servers running bash, usually shared hosting

One less-obvious difference between the modes is I'm able to use Ag in my `local-fish` environments, but instead use the more portable `ack` in `portable-bash` mode.

## Installation
1. Install [patched Powerline fonts](https://github.com/powerline/fonts)
1. `./create-links _mode_` (if using -f option, make backups of files)
1. (Optional) `./create-ssh-config`
1. Install [plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) into `.vim/autoload`
1. Install plugins `vim +PlugInstall`
1. Done.

## Uninstallation
1. Remove links generated by `create-links`
1. Restore backed up files
1. Remove/restore ssh config
1. Remove vim plugins installed via vim-plug
1. Remove fonts
