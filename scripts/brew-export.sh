#!/bin/bash

sort -o Brewfile Brewfile

# BOSSMAN is system variable, containing packages installed for BOSSMAN
# These packages will be ignored in diff.
# Don't commit them to a public repo, or else BOSSMAN comes knocking.

TEMP_BREWFILE="tmp_brewfile"
SORTED_CURRENT="sorted_brewfile"

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

# Merge: keep existing Brewfile entries, add new ones from current dump
sort -u Brewfile "$SORTED_CURRENT" -o Brewfile
rm "$TEMP_BREWFILE" "$SORTED_CURRENT"
echo "|> Brew packages list saved to Brewfile"
