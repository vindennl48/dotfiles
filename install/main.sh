#!/bin/bash

# UNCOMMENT PACKAGES YOU WOULD LIKE TO INSTALL
packages=(
  # git
  # nvim
  # zsh
  # pyenv
)

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

# Directory containing the subscripts
src_dir="$SCRIPT_DIR/src"

# Iterate over the packages
for name in "${names[@]}"; do
  # Construct the path to the subscript
  subscript="$src_dir/$name"

  # Check if the subscript exists
  if [ -e "$subscript" ]; then
    source "$subscript"
  else
    echo "Package $subscript not found!"
  fi
done

cprint -p "Finished!"
