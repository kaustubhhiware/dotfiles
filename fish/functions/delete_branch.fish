function delete_branch -d 'delete the current git branch locally and remotely'
    set current (git branch | grep \* | cut -d ' ' -f2)
    set main_branch master
    if git branch --list main | grep -q main
        set main_branch main
    end

    if [ $current = $main_branch ]
        echo ">> Are you fu**ing serious ?"
    else
        git checkout $main_branch
        echo ">> Removing branch from local"
        git branch -D $current
    end
end
