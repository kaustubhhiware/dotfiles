function gct -d 'signed git commit with ticket number'
    set ticket (git rev-parse --abbrev-ref HEAD | cut -d '-' -f 1,2)
    set commit (string join '' '[' $ticket ']' ' ' $argv)

    git commit -S -m $commit
end
