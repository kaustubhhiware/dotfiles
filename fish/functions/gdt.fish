function gdt -d 'alias for `git diff-tree`'
    git diff-tree --no-commit-id --name-only -r $argv
end
