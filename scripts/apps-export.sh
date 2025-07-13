#!/bin/bash

{
    ls -1 /Applications | rg "\.app$" | sed 's/\.app$//'
    
    if [ -d "$HOME/Applications" ]; then
        ls -1 "$HOME/Applications" | rg "\.app$" | sed 's/\.app$//'
    fi
    
    brew list --cask 2>/dev/null
} | sort -u > Appfile

echo ">> Applications list saved to Appfile"
