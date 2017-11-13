#!/bin/bash

BATT=$(acpi | egrep -o '[0-9]+%' | egrep -o '[0-9]+')

DIS="$(acpi | egrep -o 'Discharging')"

color=$(xrdb -query | grep '*color3' | awk '{print $NF}')  

if [ "$DIS" == "Discharging" ]; then
    if [ $BATT -lt 10 ];then
        #echo "%{F#ff5e6e} $BATT%"
        echo "%{F$color} $BATT%"
    elif [ $BATT -lt 20 ]; then
        #echo "%{F#ff5e6e} $BATT%"
        echo "%{F$color} $BATT%"
    elif [ $BATT -lt 30 ]; then
        #echo "%{F#fff95e} $BATT%"
        echo "%{F$color} $BATT%"
    elif [ $BATT -lt 40 ]; then
        #echo "%{F#fff95e} $BATT%"
        echo "%{F$color} $BATT%"
    elif [ $BATT -lt 50 ]; then
        #echo "%{F#fff95e} $BATT%"
        echo "%{F$color} $BATT%"
    elif [ $BATT -lt 60 ]; then
        #echo "%{F#8e98ff} $BATT%"
        echo "%{F$color} $BATT%"
    elif [ $BATT -lt 70 ]; then
        #echo "%{F#8e98ff} $BATT%"
        echo "%{F$color} $BATT%"
    elif [ $BATT -lt 80 ]; then
        #echo "%{F#8e98ff} $BATT%"
        echo "%{F$color} $BATT%"
    elif [ $BATT -le 100 ]; then
        #echo "%{F#8e98ff} $BATT%"
        echo "%{F$color} $BATT%"
    fi

else
    #echo "%{F#66ff96} $BATT%"
    echo "%{F$color} $BATT%"
fi
