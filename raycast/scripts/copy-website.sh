#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Website URL
# @raycast.mode silent
# @raycast.packageName Personal URLs
# @raycast.icon 🌐
# @raycast.iconDark 🌐

# Optional parameters:
# @raycast.description Copy your personal website URL to clipboard

# Replace with your actual website URL
WEBSITE_URL="https://kaustubhhiware.in"

echo -n "$WEBSITE_URL" | pbcopy
echo "Website URL copied to clipboard!"
