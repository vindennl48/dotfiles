#!/usr/bin/env bash

cd ~

echo "###########################################"
echo "install htop"
echo "###########################################"
sudo apt -y install htop

echo "###########################################"
echo "install silver searcher"
echo "###########################################"
sudo apt -y install silversearcher-ag

echo "###########################################"
echo "Install Vim and Tmux"
echo "###########################################"
sudo apt -y install vim tmux

echo "###########################################"
echo "Install Tree"
echo "###########################################"
sudo apt -y install tree

echo "###########################################"
echo "Install docker"
echo "###########################################"
sudo apt -y install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo gpasswd -a $USER docker

echo "###########################################"
echo "Install docker-compose"
echo "###########################################"
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "###########################################"
echo "Install heroku cli tools"
echo "###########################################"
sudo snap install heroku --classic
ln -s /snap/bin/heroku /usr/bin/heroku

echo "###########################################"
echo "installing package manager for vim"
echo "###########################################"
mkdir -p ~/.vim/autoload ~/.vim/bundle
sudo curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;

echo "###########################################"
echo "Installing Plugins"
echo "###########################################"
cd ~/.vim/bundle/
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/Yggdroot/indentLine.git
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/tpope/vim-rails.git
git clone https://github.com/christoomey/vim-tmux-navigator.git
git clone https://github.com/christoomey/vim-tmux-runner.git
git clone https://github.com/benmills/vimux.git
git clone https://github.com/tpope/vim-fugitive
git clone https://github.com/christoomey/vim-conflicted
git clone https://github.com/vimwiki/vimwiki.git

cd ~

# echo "###########################################"
# echo "install rvm manager"
# echo "###########################################"
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# sudo \curl -sSL https://get.rvm.io | bash -s stable

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

