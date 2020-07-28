function pull -d 'alias for `git pull origin $current`'
    set current (git branch | grep \* | cut -d ' ' -f2)
    git pull origin $current
end
