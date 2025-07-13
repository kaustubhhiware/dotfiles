function gop -d 'open this github repository on browser'
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo ">> Not a git repo, dumbass"
        return 1
    end
    open $(git remote get-url origin | sed 's|git@github.com:|https://github.com/|' | sed 's|\.git$||')
end
