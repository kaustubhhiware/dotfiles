function bwpw -d 'get bitwarden password into the clipboard'
    set pass SALT_PASSWORD
    echo "$(echo "$pass" | openssl base64 | rev | cut -c 5- | rev)" | pbcopy
end
