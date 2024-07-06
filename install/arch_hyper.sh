#!/bin/bash

################################################################################
## HELPER FUNCTIONS ############################################################
################################################################################
cprint() {
  local leader="     "  # Default leader

  # Process flags
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -p)
        leader="---->"
        shift
        ;;
      --)
        shift
        break
        ;;
      -*)
        echo "Unknown option: $1" >&2
        return 1
        ;;
      *)
        break
        ;;
    esac
  done

  # Print the leader followed by the remaining arguments
  echo "$leader" "$@"
}

backup() {
  # for all files listed as arguments
  for file in "$@"; do
    # rename the file with .bak
    mv "$file" "${file}.bak"
  done
}

backup_or_remove() {
  local destination="$1"

  if [ -e "$destination" ]; then
    if [ -L "$destination" ]; then
      cprint "Removing symlink: $destination"
      rm "$destination"
    else
      backup "$destination"
      # local backup_file="${destination}.bak"
      # cprint "Renaming $destination to $backup_file"
      # mv "$destination" "$backup_file"
    fi
  fi
}

press_enter() {
  printf "%s " "Press enter to continue"
  read ans
}

################################################################################
## INSTALL #####################################################################
################################################################################
cprint -p "Installing Arch Hypervisor Dependencies.."

# would you like to continue
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

pacman_packages=(
  # ttf-ibmplex-mono-nerd # default font
  git
  tar
  wget
  htop # system resources manager
  piper # logitech mouse controls
  pavucontrol # volume controls
  # DWM
  base-devel xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk
  # QEMU
  qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
  ebtables iptables libguestfs nvidia swtpm
)

# Install all packages at once
if [ ${#pacman_packages[@]} -gt 0 ]; then
  echo "Installing pacman packages: ${pacman_packages[@]}"
  sudo pacman -Syu "${pacman_packages[@]}"
else
  echo "No pacman packages to install."
fi

# Installing Git Settings
cprint -p "Installing Git Settings.."
cprint "Old Files: backing up or removing symlinks.."
backup_or_remove "$HOME/.gitconfig"

cprint "Creating new directories.."
ln -s "$HOME/bin/dotfiles/git/gitconfig" "$HOME/.gitconfig"

# Installing Suckless stuff
cprint -p "Installing Suckless Packages.."
cprint "Old Files: backing up or removing symlinks.."
backup_or_remove "$HOME/.config/suckless/dwm"
backup_or_remove "$HOME/.config/suckless/dmenu"
backup_or_remove "$HOME/.config/suckless/st"

cprint "Creating new directories.."
mkdir -p "$HOME/.config/suckless"
git clone https://github.com/vindennl48/dwm "$HOME/.config/suckless/dwm"
git clone https://git.suckless.org/dmenu "$HOME/.config/suckless/dmenu"
git clone https://git.suckless.org/st "$HOME/.config/suckless/st"

cprint "Making and installing.."
cd "$HOME/.config/suckless/dwm"; sudo make clean install
cd "$HOME/.config/suckless/dmenu"; sudo make clean install
cd "$HOME/.config/suckless/st"; sudo make clean install

cprint "Adding startup codes to user account.."
echo "exec dwm" >> "$HOME/.xinitrc"
echo '[[ -z "$DISPLAY" && $XDG_VTNR -eq 1 && -z "$SSH_CONNECTION" ]] && exec startx' >> "$HOME/.bash_profile"
echo '[[ -z "$DISPLAY" && $XDG_VTNR -eq 1 && -z "$SSH_CONNECTION" ]] && exec startx' >> "$HOME/.zprofile"

cprint "Remember to modify config.h for dwm to add your terminal to terminal source.."
press_enter

# Installing QEMU/KVM
cprint -p "Installing Libvirt/qemu/kvm.."

cprint "Starting system services.."
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
systemctl status libvirtd.service

cprint "Setting user groups"
sudo usermod -a -G libvirt $(whoami)
sudo systemctl restart libvirtd.service

# Setting up Network Bridge
cprint -p "Setting up Network Bridge.."
cprint "Copying over networkd files.."
sudo rm /etc/systemd/network/*
sudo cp $HOME/bin/dotfiles/install/network/* /etc/systemd/network/.
sudo systemctl enable systemd-networkd

# Setting up GPU passthrough
cprint -p "Downloading and extracting GPU QuickPassthrough helper.."
mkdir -p "$HOME/Downloads/quickpassthrough"
wget -O "$HOME/Downloads/quickpassthrough/qpt_2_0_6.tar.gz" "https://github.com/HikariKnight/quickpassthrough/releases/download/2.0.6/quickpassthrough_Linux_x86_64.tar.gz"
cd "$HOME/Downloads/quickpassthrough"
tar xvzf qpt_2_0_6.tar.gz
cprint "Will need to run quickpassthrough separately: it is in ~/Downloads"
press_enter

cprint -p "Install Complete!"
