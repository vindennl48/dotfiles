
echo "###########################################"
echo "install curl"
echo "###########################################"
sudo apt -y install curl

echo "###########################################";
echo "install zsh and oh-my-zsh";
echo "###########################################";

read -p "You MUST restart Ubuntu after running this script. If installing this on a Google Cloud Compute Engine VM, you must first set the password for your user account by: 'sudo passwd <username>'.  Press any key to continue or CTRL-C to cancel..." yn

sudo apt -y install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"



