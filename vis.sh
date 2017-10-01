#!/bin/bash
# --geometry=197x20+0+484
xfce4-terminal -e "vis" --hide-borders --hide-toolbar --hide-menubar --title=desktopconsole1 --geometry=197x20+0+484 &  
sleep 0.3
wmctrl -r desktopconsole1 -b add,below,sticky
wmctrl -r desktopconsole1 -b add,skip_taskbar,skip_pager
wmctrl -r desktopconsole1 -b add,modal