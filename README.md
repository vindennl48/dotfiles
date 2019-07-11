# DOTFILES
Mitchell's collection of customizations and aliases

## Current Linux Distro
 - The installer should work for both Ubuntu and Arch systems.

# Arch Installer
## What's this?
The `arch_install` and `arch_install_encrypted` are automated installers 
for arch.  They create and format the partitions and swapfile, perform 
pacstrap with a few basic packages (you can add your own to the installer 
if needed), and guide you through setting up language options, grub, wheel 
permissions etc.. 

## How to Use
Once booted into the arch live cd:
 - For regular install
   ```sh
     curl 'https://raw.githubusercontent.com/vindennl48/dotfiles/master/arch_install' > arch_install
     chmod a+x arch_install
     ./arch_install
   ```
 - For encrypted install
   ```sh
     curl 'https://raw.githubusercontent.com/vindennl48/dotfiles/master/arch_install_encrypted' > arch_install
     chmod a+x arch_install
     ./arch_install
   ```
 - The first half of the installer will create the partitions, set up pacstrap
   and arch_chroot into the new install.  Once this is complete, the installer will
   echo this to the screen:
   ```
   You must edit the copied installer in /mnt to uncomment 'post_install' and comment 'pre_install' at the bottom, then run.
   ```
   The installer copied the `arch_install` or `arch_install_encrypted` file to the new arch install root directory.  All you
   have to do is edit the very end of the file:
   - From:
     ```sh
       # Comment out the one you are NOT installing
       pre_install
       #post_install
     ```
   - To:
     ```sh
       # Comment out the one you are NOT installing
       #pre_install
       post_install
     ```
 - Now, re-run the installer and follow the prompts!

# Source All The Things
## To use the dotfiles:
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
   You will want to modify this in the installer code before you install.  
   If you install first and then try to change this, you will also need to 
   re-link all the symlinks to match this new path.

# Barebones Dotfiles
## What's This?
This is a stripped down version of my dotfiles and vim commands that I can quickly add to a remote server and not have to clutter the server with all of my own custom software and settings.  All it does is copy over a thin alias file for bash and a thin vimrc file for vim.  It then adds a line of code to the original bashrc and vimrc files to source the barebones files.  I do it this way so as to not disrupt any existing aliases or vim commands that are needed for the environment, and It's easy to remove if you aren't allowed to keep your settings on the server.

## How to use
 - You will need to curl down and run the barebones installer
   ```sh
     curl https://raw.githubusercontent.com/vindennl48/dotfiles/master/barebones/barebones_install.sh | /bin/bash
   ```

# Thats Probably It!
For a full-featured documentation, please refer to the sourced files.

