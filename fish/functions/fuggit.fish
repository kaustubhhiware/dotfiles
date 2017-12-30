function fuggit -d 'Remove pack files, and reduce the size of the repo'
    # Source: http://stevelorek.com/how-to-shrink-a-git-repository.html
    echo "> git filter-branch --tag-name-filter cat --index-filter 'git rm -r --cached --ignore-unmatch filename' --prune-empty -f -- --all"
    git filter-branch --tag-name-filter cat --index-filter 'git rm -r --cached --ignore-unmatch filename' --prune-empty -f -- --all
    
    echo "> rm -rf .git/refs/original/"
    rm -rf .git/refs/original/

    echo "> git reflog expire --expire=now --all"
    git reflog expire --expire=now --all

    echo "> git gc --prune=now"
    git gc --prune=now

    echo "> git gc --aggressive --prune=now"
    git gc --aggressive --prune=now

    echo "> git push origin --force --all"
    git push origin --force --all
    
end
