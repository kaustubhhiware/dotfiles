function gl -d 'alias for fancy `git log`'
    git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"
    # %h - commit hash
    # %an - author name
    # %ar - commit time
    # %D - ref names
    # %n - new line
    # %s - commit message
end
