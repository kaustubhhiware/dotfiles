function gch -d 'copies commit hash'
    git log --oneline | gum filter | cut -d' ' -f1 | pbcopy
end
