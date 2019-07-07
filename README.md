# DOTFILES
Mitchell's collection of customizations and aliases

## Current Linux Distro
 - The installer should work for both Ubuntu and Arch systems.

# Source All The Things
### To use this repo:
 - Clone this repo into `$HOME/bin/` or copy:
   ```sh
     mkdir ~/bin
     cd ~/bin
     git clone https://github.com/vindennl48/dotfiles
   ```
 - Install the required software for this repo to work.  You can either
   install them all manually, or try your luck with running my installer:
   - To use the installer, you must open and modify the contents to install
     the software that you need.  Pay attention to the packages that are specific
     to 'Arch' or 'Ubuntu'.  Comment out the packages you do not want and run.
   ```sh
     chmod a+x ~/bin/dotfiles/install.sh
     ~/bin/dotfiles/install.sh
   ```
  
 - You can change this directory if you choose to. If you
   do, make sure to change the directory path for the
   global variable `DOTFILES_PATH` in `~/.zshrc`
   ```sh
     export DOTFILES_PATH="<your directory here>/dotfiles"
   ```

# Thats Probably It!
For a full-featured documentation, please refer to the sourced files.

