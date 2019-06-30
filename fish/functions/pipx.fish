function pipx -d 'Whatever you do, for for python 3 and 2'
    printf "Working for python2\n"
    sudo pip2 $argv
    printf "\nWorking for python3\n"
    sudo pip3 $argv
end
