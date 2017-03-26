
echo "installing package manager for vim"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
sudo curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Installing Plugins"
git clone https://github.com/kien/ctrlp.vim.git
https://github.com/Yggdroot/indentLine.git
https://github.com/scrooloose/nerdcommenter.git
https://github.com/scrooloose/nerdtree.git
https://github.com/tpope/vim-rails.git
https://github.com/christoomey/vim-tmux-navigator.git
https://github.com/christoomey/vim-tmux-runner.git
https://github.com/benmills/vimux.git
https://github.com/tpope/vim-fugitive
https://github.com/christoomey/vim-conflicted
