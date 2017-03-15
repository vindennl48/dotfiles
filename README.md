# dotfiles
Mitchell's collection of customizations and aliases

## Current Linux Distro
 - Arch Linux: Antergos x64: https://antergos.com/

## Source All The Things
To get this repo working, you will need to set some environment variables.

### Inside .zshrc
```sh
  # Create dotfiles directory variable
  export DOTFILES_PATH="$HOME/bin/dotfiles"
  # Source zshrc
  source $DOTFILES_PATH/bash/zshrc
```

### Inside .vimrc
```sh
  # Path to tmux config file
  :so $MYVIMPATH/source_me.vim
```

### Inside .tmux.conf
```sh
  # Path to tmux config file
  source-file $MYTMUXPATH/tmux_bindings
```

# Requirements

## Vim Required Plugin List
 Plugin Manager
  - Pathogen https://github.com/tpope/vim-pathogen.git

 Plugins
  - ctrlp.vim https://github.com/kien/ctrlp.vim.git
  - indentLine https://github.com/Yggdroot/indentLine.git
  - nerdcommenter https://github.com/scrooloose/nerdcommenter.git
  - nerdtree https://github.com/scrooloose/nerdtree.git
  - vim-rails https://github.com/tpope/vim-rails.git
  - vim-tmux-navigator https://github.com/christoomey/vim-tmux-navigator.git
  - vim-tmux-runner https://github.com/christoomey/vim-tmux-runner.git
  - vimux https://github.com/benmills/vimux.git

## Additional Required Software
You will need:
 - Tmux (pacman)
 - Vim (pacman)
 - Oh-My-Zsh https://github.com/robbyrussell/oh-my-zsh
 - AG https://github.com/ggreer/the_silver_searcher
 - fzf https://github.com/junegunn/fzf
 - A shot of malt liquor

## Extras - Not Required
Other Programs I typically install:

Installed with `pacman`
 - feh - Terminal Image Viewer (for wallpaper)
 - htop - Interactive Process viewer
 - termite - Lightweight Terminal

## Thats It!
For a full-featured documentation, please refer to the sourced files.

