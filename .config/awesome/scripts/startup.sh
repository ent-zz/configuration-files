#!/bin/bash
urxvt -name screen -e /home/ent/.config/awesome/scripts/screenlaunch.sh &
firefox &
urxvt -name ssh -e /home/ent/.config/awesome/scripts/sshlaunch.sh &
#urxvt -name finch -e /home/ent/.config/awesome/scripts/chatlaunch.sh &
pidgin &
