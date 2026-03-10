#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Bwpw
# @raycast.mode silent
# @raycast.packageName Security
# @raycast.icon 🔑
# @raycast.iconDark 🔑

# Optional parameters:
# @raycast.description Copy your bwpw to clipboard

# Documentation:
# @raycast.author Kaustubh

# What is bwpw? I don't have to tell you.
BWPW="salt_platform"

echo -n "$BWPW" | openssl base64 | pbcopy
echo "BWPW copied to clipboard!"
