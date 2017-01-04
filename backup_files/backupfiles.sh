#!/usr/bin/env bash

# This is to backup possibly important files and make sure my
# work computer is synched up to my home computer

# make sure mybash is synched properly
# by going into mybash and pull/push all data
put_mybash(){
    cd ~/bin/mybash
    git add .
    git commit -m "update code"
    git pull origin master --no-edit
    git push -u origin master
}
get_mybash(){
    cd ~/bin/mybash
    git pull origin master --no-edit
}

# make sure .vimrc is synched
put_vimrc(){
    cd ~
    cp .vimrc ~/bin/mybash/backup_files/.vimrc
}

# make sure .vimrc is synched
get_vimrc(){
    cd ~/bin/mybash/backup_files/
    cp .vimrc ~/.vimrc
}

# actual sript
if [ $1 = "load" ]; then
    get_mybash
    get_vimrc
elif [ $1 = "save" ]; then
    put_vimrc
    put_mybash
else
    echo "that is not a valid argument"
fi
