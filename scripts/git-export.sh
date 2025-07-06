SOURCE_CONFIG=~/.gitconfig
DEST_CONFIG=./gitconfig

if ! cmp -s "$SOURCE_CONFIG" "$DEST_CONFIG"; then
    echo ">> Different content in gitconfigs"
    diff -u "$DEST_CONFIG" "$SOURCE_CONFIG" | diff-so-fancy
    echo ""
else
    echo ">> gitconfigs are identical"
fi