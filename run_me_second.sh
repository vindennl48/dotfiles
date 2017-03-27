#!/usr/bin/env bash


run_installer() {
  # Install the zsh rc file
  if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.old
  fi

  echo '# Create dotfiles directory variable' > ~/.zshrc
  echo 'export DOTFILES_PATH="$HOME/bin/dotfiles"' >> ~/.zshrc
  echo '# Source zshrc' >> ~/.zshrc
  echo 'source $DOTFILES_PATH/bash/zshrc' >> ~/.zshrc

  # Install the vim rc file
  if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.old
  fi

  echo '# Path to tmux config file' > ~/.vimrc
  echo ':so $MYVIMPATH/source_me.vim' >> ~/.vimrc

  # Install the tmux configuration file
  if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.old
  fi

  echo '# Path to tmux config file' > ~/.tmux.conf
  echo 'source-file $MYTMUXPATH/tmux_bindings' >> ~/.tmux.conf
}

run_installer
