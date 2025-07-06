function bwpw -d 'get bitwarden password into the clipboard'
    set bwpw SALT_PASSWORD
    echo "$(echo "$bwpw" | openssl base64 | rev | cut -c 5- | rev)" | pbcopy
end
