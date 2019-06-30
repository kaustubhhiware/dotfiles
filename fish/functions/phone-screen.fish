function phone-screen -d 'Display usb-connected phone screen'
	adb shell screenrecord --output-format=h264 - | ffplay -
end
