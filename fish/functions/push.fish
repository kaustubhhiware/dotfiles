function push -d 'alias for `git push origin $current`'
    set current (git branch | grep \* | cut -d ' ' -f2)

    if [ $current = master ]; or [ $current = main ]
        set remote_url (git remote get-url origin 2>/dev/null)
        set owner (string match -r 'github\.com[/:]([^/]+)/' $remote_url)[2]
        if [ "$owner" = kaustubhhiware ]
            echo ">> Only because this is your repo, I'll let you push to master"
            git push origin $current $argv
        else
            echo ">> Are you fu**ing serious ?"
        end
    else
        git push origin $current $argv
    end
end
