function push -d 'alias for `git push origin $current`'
    set current (git branch | grep \* | cut -d ' ' -f2)

    if [ $current = "master" ]
        echo "Are you fu**ing serious ?"
    else
        git push origin $current $argv
    end
end
