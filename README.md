# DOTFILES
Mitchell's collection of customizations and aliases

## Current Linux Distro
 - Arch Linux: Antergos x64: https://antergos.com/

# Source All The Things
### To use this repo:
 - Clone this repo into `$HOME/bin/` or copy:
   ```sh
     mkdir ~/bin
     cd ~/bin
     git clone https://github.com/vindennl48/dotfiles
   ```
 - Install the required software for this repo to work.  You can either
   install them all manually, or try your luck with running my installer:
   ```sh
     cd ~/bin/dotfiles
     chmod a+x run_me_first.sh
     ./run_me_first.sh
   ```

 - Navigate to `$HOME/bin/dotfiles` in the terminal and run `install_me.sh`
   ```sh
     cd ~/bin/dotfiles
     chmod a+x run_me_second.sh
     ./run_me_second.sh
   ```
 - You can change this directory if you choose to. If you
   do, make sure to change the directory path for the
   global variable `DOTFILES_PATH` in `~/.zshrc`
   ```sh
     export DOTFILES_PATH="<your directory here>/dotfiles"
   ```
 - Thats It!

# Requirements

## Vim Required Plugin List
 Plugin Manager
  - Pathogen | https://github.com/tpope/vim-pathogen.git

 Plugins
  - ctrlp.vim | https://github.com/kien/ctrlp.vim.git
  - indentLine | https://github.com/Yggdroot/indentLine.git
  - nerdcommenter | https://github.com/scrooloose/nerdcommenter.git
  - nerdtree | https://github.com/scrooloose/nerdtree.git
  - vim-rails | https://github.com/tpope/vim-rails.git
  - vim-tmux-navigator | https://github.com/christoomey/vim-tmux-navigator.git
  - vim-tmux-runner | https://github.com/christoomey/vim-tmux-runner.git
  - vimux | https://github.com/benmills/vimux.git
  - fugitive | https://github.com/tpope/vim-fugitive
  - conflicted | https://github.com/christoomey/vim-conflicted

## Additional Required Software
You will need:
 - Tmux | (pacman)
 - Vim | (pacman)
 - Oh-My-Zsh | https://github.com/robbyrussell/oh-my-zsh
 - AG | https://github.com/ggreer/the_silver_searcher
 - fzf | https://github.com/junegunn/fzf
 - A shot of malt liquor

## Extras - Not Required
Other Programs I typically install:

Installed with `pacman`
 - htop | Interactive Process viewer
 - termite | Lightweight Terminal
 - hub | Github cli

Installed from the Interwebs
 - RVM ruby version manager | https://rvm.io/

# Thats It!
For a full-featured documentation, please refer to the sourced files.

