function gbs --description 'Choose a branch based on last update and switch to it'
    set branches (git for-each-ref --sort=-committerdate --count=10 --format='%(refname:short) | %(color:green)%(committerdate:relative)%(color:reset)' refs/heads/)
    set selected_branch (printf "%s\n" $branches | gum choose --header "Select a branch to switch to:")

    if test -n "$selected_branch"
        set branch_name (string split ' | ' $selected_branch)[1]
        git switch "$branch_name"
    else
        echo "No branch selected. Aborting."
    end
end
