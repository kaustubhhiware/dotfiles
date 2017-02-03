function plsfind
    sudo find ~/ -type f|~/recentmost $argv[1] | grep $argv[2]
end
