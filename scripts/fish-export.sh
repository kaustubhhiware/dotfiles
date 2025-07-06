#!/bin/bash

SOURCE_DIR=~/.config/fish/
DEST_DIR=./fish/


# Compare config.fish first
SOURCE_CONFIG="$SOURCE_DIR/config.fish"
DEST_CONFIG="$DEST_DIR/config.fish"

if ! cmp -s "$SOURCE_CONFIG" "$DEST_CONFIG"; then
    echo "Different content: config.fish"
    diff -u "$DEST_CONFIG" "$SOURCE_CONFIG" | diff-so-fancy
    echo ""
else
    echo "config.fish files are identical"
fi

echo "Comparing functions folder..."

FUNCTIONS_SOURCE="$SOURCE_DIR/functions"
FUNCTIONS_DEST="$DEST_DIR/functions"

for source_file in "$FUNCTIONS_SOURCE"/*.fish; do
    if [ -f "$source_file" ]; then
        filename=$(basename "$source_file")
        dest_file="$FUNCTIONS_DEST/$filename"
        
        if [ ! -f "$dest_file" ]; then
            echo "Missing in destination: $filename - copying..."
            cp "$source_file" "$dest_file"
        elif ! cmp -s "$source_file" "$dest_file"; then
            echo "Different content: $filename"
            echo "Showing diff using diff-so-fancy:"
            diff -u "$dest_file" "$source_file" | diff-so-fancy
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
            echo "Extra in destination: $filename"
        fi
    fi
done
