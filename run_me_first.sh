read -p "You MUST restart Ubuntu after running this script. If installing this on a Google Cloud Compute Engine VM, you must first set the password for your user account by: 'sudo passwd <username>'.  Press any key to continue or CTRL-C to cancel..." yn

isDebian=$(type -P apt-get)
isArch=$(type -P pacman)

echo "###########################################"
echo "update system"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt update && sudo apt -y upgrade
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -Syu
fi

echo "###########################################"
echo "install curl"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt-get install -y curl
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -S curl
fi

echo "###########################################"
echo "install rvm, rails, nodejs"
echo "###########################################"
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt -y install software-properties-common
  sudo apt-add-repository -y ppa:rael-gc/rvm
  sudo apt update
  # sudo apt -y install rvm
  # sudo adduser $USER rvm
elif [[ "$isArch" =~ ^/ ]]; then
  curl -L get.rvm.io > rvm-install && bash < ./rvm-install
fi

echo "###########################################";
echo "install zsh and oh-my-zsh";
echo "###########################################";
if [[ "$isDebian" =~ ^/ ]]; then
  sudo apt -y install zsh
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
elif [[ "$isArch" =~ ^/ ]]; then
  sudo pacman -S zsh zsh-completions
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
