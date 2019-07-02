#!/usr/bin/env bash

# Run this then restart terminal
# curl https://raw.githubusercontent.com/vindennl48/dotfiles/master/barebones_install.sh | /bin/bash

echo "----> Installing Bash aliases.."
curl https://raw.githubusercontent.com/vindennl48/dotfiles/master/barebones_bash.alias -o ~/.bashrc2
echo "source ~/.bashrc2" >> ~/.bashrc

echo "----> Installing Vim aliases.."
curl https://raw.githubusercontent.com/vindennl48/dotfiles/master/barebones_vim.vim -o ~/.vimrc2
echo "source ~/.vimrc2" >> ~/.vimrc

echo "----> Finished installing!"

