#!/bin/bash

# Check if BOSSMAN is empty
# BOSSMAN="name1|name2|name3" sh scripts/fish-export.sh
if [ ! -n "$BOSSMAN" ]; then
    echo ">> Error: BOSSMAN variable is empty"
    exit 1
fi

SOURCE_DIR=~/.config/fish/
DEST_DIR=./fish/

# BOSSMAN wouldn't like me pushing these files to an open repository
IGNORE_FILES=(
    "kp.fish"
    "mat.fish"
    "pat.fish"
)


# Compare config.fish first
SOURCE_CONFIG="$SOURCE_DIR/config.fish"
DEST_CONFIG="$DEST_DIR/config.fish"

if ! cmp -s "$SOURCE_CONFIG" "$DEST_CONFIG"; then
    echo ">> Different content: config.fish"
    diff -u "$DEST_CONFIG" "$SOURCE_CONFIG" | grep -v -E "$BOSSMAN" | diff-so-fancy
    echo ""
else
    echo ">> config.fish files are identical"
fi

echo ">> Comparing functions folder..."

FUNCTIONS_SOURCE="$SOURCE_DIR/functions"
FUNCTIONS_DEST="$DEST_DIR/functions"

for source_file in "$FUNCTIONS_SOURCE"/*.fish; do
    if [ -f "$source_file" ]; then
        filename=$(basename "$source_file")
        
        # Check if file is in ignore list
        if [[ " ${IGNORE_FILES[@]} " =~ " ${filename} " ]]; then
            echo ">> Ignoring: $filename"
            continue
        fi
        
        dest_file="$FUNCTIONS_DEST/$filename"
        
        if [ ! -f "$dest_file" ]; then
            echo ">> Missing in destination: $filename - copying..."
            cp "$source_file" "$dest_file"
        elif ! cmp -s "$source_file" "$dest_file"; then
            echo ">> Different content: $filename"
            diff -u "$dest_file" "$source_file" | grep -v -E "$BOSSMAN" | diff-so-fancy
            echo ""
        fi
    fi
done

# Find files that exist in destination but not in source
for dest_file in "$FUNCTIONS_DEST"/*.fish; do
    if [ -f "$dest_file" ]; then
        filename=$(basename "$dest_file")
        source_file="$FUNCTIONS_SOURCE/$filename"
        
        if [ ! -f "$source_file" ]; then
            echo ">> Extra in destination: $filename"
        fi
    fi
done
