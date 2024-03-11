function gbs -d 'Check last update for each local branch'
    git for-each-ref --sort=-committerdate --count=10 --format='%(color:green)%(committerdate:relative)%(color:reset) %(refname:short)' refs/heads/
end
