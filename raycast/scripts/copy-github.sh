#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy GitHub URL
# @raycast.mode silent
# @raycast.packageName Developer URLs
# @raycast.icon 🐙
# @raycast.iconDark 🐙

# Optional parameters:
# @raycast.description Copy your GitHub profile URL to clipboard

# Replace with your actual GitHub URL
GITHUB_URL="https://github.com/kaustubhhiware"

echo -n "$GITHUB_URL" | pbcopy
echo "GitHub URL copied to clipboard!"
