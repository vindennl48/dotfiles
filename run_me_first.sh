#!bin/bash

echo "###########################################";
echo "install termite";
echo "###########################################";
sudo pacman -S termite;

echo "###########################################";
echo "install htop";
echo "###########################################";
sudo pacman -S htop;

echo "###########################################";
echo "install hub for github";
echo "###########################################";
sudo pacman -S hub;

echo "###########################################";
echo "install silver searcher";
echo "###########################################";
sudo pacman -S the_silver_searcher;

echo "###########################################";
echo "install fzf";
echo "###########################################";
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
~/.fzf/install;

echo "###########################################";
echo "Install Vim and Tmux";
echo "###########################################";
sudo pacman -S vim;
sudo pacman -S tmux;

echo "###########################################";
echo "installing package manager for vim";
echo "###########################################";
mkdir -p ~/.vim/autoload ~/.vim/bundle;
sudo curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;

echo "###########################################";
echo "Installing Plugins";
echo "###########################################";
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
git clone https://github.com/vimwiki/vimwiki.git;

cd ~

echo "###########################################";
echo "install rvm manager"
echo "###########################################";
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
sudo \curl -sSL https://get.rvm.io | bash -s stable

echo "###########################################";
echo "install zsh and oh-my-zsh";
echo "###########################################";
sudo pacman -S zsh;
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";


