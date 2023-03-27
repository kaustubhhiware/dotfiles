function delete_merged -d 'deletes local branches that have been merged'
    git branch --format "%(refname:short)" | grep -v master | xargs git branch -D
end
