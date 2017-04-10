#!bin/bash
# Create symlinks for openbox

rm $HOME/.config/openbox/autostart
rm $HOME/.config/openbox/rc.xml
rm $HOME/.config/conky.conf

ln -sf $HOME/bin/dotfiles/openbox/autostart $HOME/.config/openbox/autostart
ln -sf $HOME/bin/dotfiles/openbox/rc.xml $HOME/.config/openbox/rc.xml
ln -sf $HOME/bin/dotfiles/openbox/conky.conf $HOME/.config/conky.conf


