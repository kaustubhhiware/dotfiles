function notify-after -d 'notify, with cmux'
    $argv
    # Source: https://cmux.com/docs/notifications
    set exit_code $status
    if test $exit_code -eq 0
        cmux notify --title "✓ Command Complete" --body "$argv[1]"
    else
        cmux notify --title "✗ Command Failed" --body "$argv[1] (exit $exit_code)"
    end
    return $exit_code
end
