
echo "###########################################"
echo "install curl"
echo "###########################################"
sudo apt -y install curl

echo "###########################################";
echo "install zsh and oh-my-zsh";
echo "###########################################";

read -p "You MUST restart Ubuntu after running this script. Press any key to continue..." yn

sudo apt -y install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"



