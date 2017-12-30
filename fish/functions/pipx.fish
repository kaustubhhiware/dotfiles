function pipx -d 'Whatever you do, do for both python 2 and 3'
    printf "Working for python2\n"
    sudo pip2 $argv
    printf "\nWorking for python3\n"
    sudo pip3 $argv
end
