#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy LinkedIn URL
# @raycast.mode silent
# @raycast.packageName Social Media URLs
# @raycast.icon 🔗
# @raycast.iconDark 🔗

# Optional parameters:
# @raycast.description Copy your LinkedIn profile URL to clipboard

# Documentation:
# @raycast.author Kaustubh
# @raycast.authorURL https://raycast.com/kaustubh

# Replace with your actual LinkedIn URL
LINKEDIN_URL="https://linkedin.com/in/ofkaus"

echo -n "$LINKEDIN_URL" | pbcopy
echo "LinkedIn URL copied to clipboard!"
