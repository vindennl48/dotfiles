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
 Plugin Manager
  - Pathogen
    https://github.com/tpope/vim-pathogen.git

 Plugins
  - ctrlp.vim
    https://github.com/kien/ctrlp.vim.git
  - indentLine
    https://github.com/Yggdroot/indentLine.git
  - nerdcommenter
    https://github.com/scrooloose/nerdcommenter.git
  - nerdtree
    https://github.com/scrooloose/nerdtree.git
  - vim-rails
    https://github.com/tpope/vim-rails.git
  - vim-tmux-navigator
    https://github.com/christoomey/vim-tmux-navigator.git
  - vim-tmux-runner
    https://github.com/christoomey/vim-tmux-runner.git
  - vimux
    https://github.com/benmills/vimux.git

## Requirements
You will need:
 - Oh-My-Zsh
 - Tmux
 - Vim
 - A shot of malt liquor

## Thats It!
For a full-featured documentation, please refer to the sourced files.

