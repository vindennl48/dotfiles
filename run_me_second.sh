#!/usr/bin/env bash

cd ~

isDebian=$(type -P apt-get)
isArch=$(type -P pacman)

echo "###########################################"
echo "install git"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt -y install git
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -S git
fi
read -p "Enter your Github email address: " email
read -p "Enter your first and last name: " fullname
git config --global user.email "$email"
git config --global user.email "$fullname"

echo "###########################################"
echo "install htop"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt -y install htop
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -S htop
fi

echo "###########################################"
echo "install silver searcher"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt -y install silversearcher-ag
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -S the_silver_searcher
fi

echo "###########################################"
echo "Install Neovim and Tmux"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt-add-repository ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt -y install neovim tmux
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -S neovim tmux
fi
mkdir -p ~/.local/share/nvim/site/autoload/
mkdir -p ~/.config/nvim/
echo ':source $MYNVIMPATH/init.vim' > ~/.config/nvim/init.vim
git clone https://github.com/junegunn/vim-plug.git ~/.local/share/nvim/site/autoload/vim-plug
cp ~/.local/share/nvim/site/autoload/vim-plug/plug.vim ~/.local/share/nvim/site/autoload/.
rm -Rf ~/.local/share/nvim/site/autoload/vim-plug

echo "###########################################"
echo "Install Tree"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt -y install tree
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -S tree
fi

echo "###########################################"
echo "Install openssh"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt -y install openssh-server
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -S openssh
fi
sudo systemctl restart ssh

# echo "###########################################"
# echo "Install docker"
# echo "###########################################"
# sudo apt -y install docker.io
# sudo systemctl start docker
# sudo systemctl enable docker
# sudo groupadd docker
# sudo gpasswd -a $USER docker
# 
# echo "###########################################"
# echo "Install docker-compose"
# echo "###########################################"
# sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# echo "###########################################"
# echo "Install heroku cli tools"
# echo "###########################################"
# sudo snap install heroku --classic
# ln -s /snap/bin/heroku /usr/bin/heroku

echo "###########################################"
echo "install rvm, rails, nodejs"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt -y install nodejs libpq-dev
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -S nodejs
fi
# might have to be done manually
# rvm install ruby
# might have to be done manually
# gem install rails

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
  echo 'source $DOTFILES_PATH/bash/bashrc' >> ~/.zshrc

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

