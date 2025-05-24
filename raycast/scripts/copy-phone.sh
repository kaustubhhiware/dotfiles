#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Phone Number
# @raycast.mode silent
# @raycast.packageName Contact Info
# @raycast.icon 📞
# @raycast.iconDark 📞

# Optional parameters:
# @raycast.description Copy your phone number to clipboard

# Documentation:
# @raycast.author Kaustubh
# @raycast.authorURL https://raycast.com/kaustubh

# Replace with your actual phone number
PHONE_NUMBER="oh-brother"

echo -n "$PHONE_NUMBER" | pbcopy
echo "Phone number copied to clipboard!"
