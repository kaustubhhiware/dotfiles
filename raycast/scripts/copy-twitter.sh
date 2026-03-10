#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Twitter URL
# @raycast.mode silent
# @raycast.packageName Social Media URLs
# @raycast.icon 🐦
# @raycast.iconDark 🐦

# Optional parameters:
# @raycast.description Copy your Twitter profile URL to clipboard

# Replace with your actual Twitter URL
TWITTER_URL="https://x.com/_ofkaus"

echo -n "$TWITTER_URL" | pbcopy
echo "Twitter URL copied to clipboard!"
