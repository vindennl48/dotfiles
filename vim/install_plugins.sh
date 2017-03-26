#!usr/bin/env bash

echo "install termite";
sudo pacman -S termite;

echo "install htop";
sudo pacman -S htop;

echo "install hub for github";
sudo pacman -S hub;

echo "install silver searcher";
sudo pacman -S the_silver_searcher;

echo "install fzf";
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
~/.fzf/install;

echo "install zsh and oh-my-zsh";
sudo pacman -S zsh;
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";

echo "Install Vim and Tmux";
sudo pacman -S vim;
sudo pacman -S tmux;

echo "installing package manager for vim";
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
sudo curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;

echo "Installing Plugins";
cd ~/.vim/bundle/;
git clone https://github.com/kien/ctrlp.vim.git;
git clone https://github.com/Yggdroot/indentLine.git;
git clone https://github.com/scrooloose/nerdcommenter.git;
git clone https://github.com/scrooloose/nerdtree.git;
git clone https://github.com/tpope/vim-rails.git;
git clone https://github.com/christoomey/vim-tmux-navigator.git;
git clone https://github.com/christoomey/vim-tmux-runner.git;
git clone https://github.com/benmills/vimux.git;
git clone https://github.com/tpope/vim-fugitive;
git clone https://github.com/christoomey/vim-conflicted;

echo "install rvm manager"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
sudo \curl -sSL https://get.rvm.io | bash -s stable

