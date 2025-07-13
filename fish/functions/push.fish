function push -d 'alias for `git push origin $current`'
    set current (git branch | grep \* | cut -d ' ' -f2)

    if [ $current = "master" ]
        echo ">> Are you fu**ing serious ?"
    else if [ $current = "main" ]
        echo ">> You're a special kind of stupid"
    else
        git push origin $current $argv
    end
end
