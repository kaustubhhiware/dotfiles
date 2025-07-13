#!/bin/bash

# BOSSMAN is system variable, containing packages installed for BOSSMAN
# These packages will be ignored in diff.
# Don't commit them to a public repo, or else BOSSMAN comes knocking.

TEMP_BREWFILE=$(mktemp)
SORTED_EXISTING=$(mktemp)
SORTED_CURRENT=$(mktemp)

brew bundle dump --file="$TEMP_BREWFILE"

if [ ! -f "Brewfile" ]; then
    echo "No existing Brewfile found"
    rm "$TEMP_BREWFILE" "$SORTED_CURRENT"
    exit 0
fi

if [ ! -n "$BOSSMAN" ]; then
    echo "Error: BOSSMAN variable is empty"
    rm "$TEMP_BREWFILE" "$SORTED_CURRENT"
    exit 1
fi

sort "$TEMP_BREWFILE" | grep -v "$BOSSMAN" > "$SORTED_CURRENT"

# Assumes Brewfile is kept sorted
diff -u Brewfile "$SORTED_CURRENT" | diff-so-fancy

rm "$TEMP_BREWFILE" "$SORTED_CURRENT"
