#!/usr/bin/env bash

cd ~

echo "###########################################"
echo "install fzf"
echo "###########################################"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

run_installer() {
  # Install the zsh rc file
  echo "###########################################"
  echo "Replace zshrc file"
  echo "###########################################"
  if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.old
  fi

  echo '# Create dotfiles directory variable' > ~/.zshrc
  echo 'export DOTFILES_PATH="$HOME/bin/dotfiles"' >> ~/.zshrc
  echo '# Source zshrc' >> ~/.zshrc
  echo 'source $DOTFILES_PATH/bash/zshrc' >> ~/.zshrc

  # Install the vim rc file
  echo "###########################################"
  echo "Replace vimrc file"
  echo "###########################################"
  if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.old
  fi

  echo '" Path to tmux config file' > ~/.vimrc
  echo ':so $MYVIMPATH/source_me.vim' >> ~/.vimrc

  # Install the tmux configuration file
  echo "###########################################"
  echo "Replace tmux.conf file"
  echo "###########################################"
  if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.old
  fi

  echo '# Path to tmux config file' > ~/.tmux.conf
  echo 'source-file $MYTMUXPATH/tmux_bindings' >> ~/.tmux.conf

  # install git config file
  echo "###########################################"
  echo "Replace gitconfig file"
  echo "###########################################"
  if [ -f ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.gitconfig.old
  fi

  cp ~/bin/dotfiles/git/gitconfig ~/.gitconfig
}

run_installer
