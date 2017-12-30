function list -d 'list all dirs in folder with sizes'
    du -hs ./* | sort -n
    echo ''
    sizeof .
end
