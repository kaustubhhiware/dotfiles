function review -d 'fetch branch from remote for review'
    git fetch origin $argv
    git checkout $argv
end
