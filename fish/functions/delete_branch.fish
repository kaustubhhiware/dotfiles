function delete_branch -d 'delete the current git branch locally and remotely'
    set current (git branch | grep \* | cut -d ' ' -f2)

    if [ $current = "master" ]
        echo "Are you fu**ing serious ?"
    else if [ $current = main ]
        echo "You're a special kind of stupid"
    else
        git checkout master
        echo "Removing branch from local"
        git branch -D $current
    end
end
