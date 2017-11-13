#!/bin/bash
# \uf294
icon_enabled=" " #"" # "ON"
icon_disabled=" " #""
status=`systemctl is-active bluetooth.service`

if [ $status == "active" ]
then
	echo "$icon_enabled"
else
	echo "$icon_disabled"
fi
