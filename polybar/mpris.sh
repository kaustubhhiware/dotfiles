#!/usr/bin/env bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
music=""
previous=""
next=""
pause=""
play=""
# music_metadata_file="~/.config/polybar/.music_metadata.txt"

player_status=$(playerctl status 2>&1)

# Foreground color formatting tags are optional
# if [[ $(playerctl status 2>&1 | grep "No players found") -ne "" ]] ; then
if [ "$player_status" == "No players found" ] ; then
	echo ""

else
	metadata="$(playerctl metadata title) - $(playerctl metadata artist)"
	appname="$(playerctl -l)"
	case "$1" in
		--prev)
			echo " $previous"
		;;
		--toggle)
			if [[ $player_status -eq "Playing" ]] ; then
				echo "$pause"
			else
				echo "$play"
			fi
		;;
		--notify)
			if [[ $appname -eq "spotify" ]]; then
				notify-send "$(playerctl metadata title)" "$(playerctl metadata artist) - $(playerctl metadata xesam:album)"  -i spotify
			else
				notify-send "$(lsof -F n -c vlc | grep -E '^.*\.mp4|^.*\.mkv|^.*\.avi'| awk -F'/' ' { print $(NF) } ')" "$(playerctl metadata artist)"  -i vlc
			fi
		;;
		--next)
			echo "$next"
		;;
		--metadata)
			if [ ! -f .music_metadata_file ] ; then
				echo 0 > .music_metadata_file
			fi
			read music_metadata < .music_metadata_file
			if [[ $music_metadata = "0" ]] ; then
				echo "$music"
			else
				# echo $(printenv | grep show_polybar_music_metadata)
				if [[ $appname -eq "spotify" ]]; then
					echo "%{F#D08770}$music $metadata" # Orange, because why not
				else
					echo "%{F#D08770}$music $(lsof -F n -c vlc | grep -E '^.*\.mp4|^.*\.mkv|^.*\.avi'| awk -F'/' ' { print $(NF) } ')"
				fi
			fi
		;;
		--togglemetadata)
			if [ ! -f .music_metadata_file ] ; then
				echo 0 > .music_metadata_file
			fi
			read music_metadata < .music_metadata_file
			if [[ $music_metadata = "0" ]] ; then
				echo 1 > .music_metadata_file
			else
				echo 0 > .music_metadata_file
			fi
		;;
		*)
			echo "?"
		;;	
	esac
fi
