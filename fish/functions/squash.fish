function squash -d 'squash previous num commits in current folder'
    if count $argv > /dev/null
        set -x numcommits $argv[1]
        printf ">> Squashing previous %d commits\n", $numcommits
        git rebase -i HEAD~$numcommits
        printf ">> push your squashed commits with `git push --force`\n"
    else
        printf ">> Need to use as - squash number_of_commits\n"
    end
end
