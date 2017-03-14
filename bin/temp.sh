#!/usr/bin/env bash
set -e
set -o pipefail
###################

dotfiles_exists=$(tmux list-sessions | sed 's/:.*$//' | grep dotfiles)

if [ $dotfiles_exists != "dotfiles" ]; then
  tmux new-session -d -s dotfiles
fi
