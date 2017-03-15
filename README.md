# dotfiles
Mitchell's collection of customizations and aliases

## Source All The Things
To get this repo working, you will need to set some environment variables.

### Inside .zshrc
```sh
  # Path to the repo directory
  export DOTFILES_PATH="/home/mitch/bin/dotfiles"
  # Source in the main file of the repo
  source $DOTFILES_PATH/source_me
  
  # To allow fzf to work properly with ohmyzsh
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  
  # This is to make sure that tmux is running everytime
  #  a terminal is opened.
  _not_inside_tmux() { [[ -z "$TMUX" ]] }
  ensure_tmux_is_running() {
    if _not_inside_tmux; then
      tat
    fi
  }
  ensure_tmux_is_running
```

### Inside .tmux.conf
```sh
  # Path to tmux config file
  source-file $MYTMUXPATH/tmux_bindings
```

## Vim Plugin List
 - ctrlp.vim
 - indentLine
 - L9
 - nerdcommenter
 - nerdtree
 - newL9
 - tlib_vim
 - vim-bundler
 - vim-rails
 - vim-tmux-navigator
 - vim-tmux-runner
 - vimux

## Requirements
You will need:
 - Oh-My-Zsh
 - Tmux
 - Vim
 - A shot of malt liquor

## Thats It!
For a full-featured documentation, please refer to the sourced files.

## Over And Out
## out
### out
#### out
##### out
###### out
