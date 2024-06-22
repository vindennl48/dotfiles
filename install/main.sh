#!/bin/bash

################################################################################
## CUSTOM MODULES ##############################################################
################################################################################
# UNCOMMENT PACKAGES YOU WOULD LIKE TO INSTALL
packages=(
  # git
  # yay
  # zsh
  # nvim
  # tmux
  # pyenv
  # alacritty
  # dwm
  # qemu
)

pacman_packages=(
  # piper
  # htop
  # pavucontrol
)
################################################################################
################################################################################

################################################################################
## INITIAL SETUP ###############################################################
################################################################################
# Get the directory of the currently executing script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Import helpers
source "$SCRIPT_DIR/src/helpers"
cprint "Installing packages: ${packages[*]}"
# would you like to continue
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

################################################################################
## INSTALLING PACMAN PACKAGES ##################################################
################################################################################
for pkg in "${pacman_packages[@]}"; do
  packages_to_install+=("$pkg")
done

# Install all packages at once
if [ ${#pacman_packages[@]} -gt 0 ]; then
  echo "Installing pacman packages: ${pacman_packages[@]}"
  sudo pacman -Syu --noconfirm "${pacman_packages[@]}"
else
  echo "No pacman packages to install."
fi

################################################################################
## INSTALLING CUSTOM MODULES ###################################################
################################################################################
# Directory containing the subscripts
src_dir="$SCRIPT_DIR/src"

# Iterate over the packages
for package in "${packages[@]}"; do
  # Construct the path to the subscript
  subscript="$src_dir/$package"

  # Check if the subscript exists
  if [ -e "$subscript" ]; then
    source "$subscript"
  else
    echo "Package $subscript not found!"
  fi
done

cprint -p "Finished!"
