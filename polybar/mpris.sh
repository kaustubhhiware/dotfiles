#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""
play=" Playing "
pause=" Pause "
prev=" Prev "
next=" Next "

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "$prev %{F#D08770}$pause $next $metadata"       # Orange when playing
elif [[ $player_status = "Paused" ]]; then
    echo "$prev %{F#65737E}$play $next $metadata"       # Greyed out info when paused
else
    echo "%{F#65737E}$icon"                 # Greyed out icon when stopped
fi
