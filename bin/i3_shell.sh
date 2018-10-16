#!/bin/bash
WHEREAMI=$(cat /tmp/whereami)
#i3-sensible-terminal --working-directory="$WHEREAMI"
#gnome-terminal --working-directory="$WHEREAMI"
termite -d $WHEREAMI -e /bin/zsh
