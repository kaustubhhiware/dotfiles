function cst --description "Show current Claude usage stats (5h and 7d utilization)"
    set cache_file /tmp/claude/statusline-usage-cache.json
    mkdir -p /tmp/claude

    set usage_data ""
    set needs_refresh true

    if test -f $cache_file
        set cache_mtime (stat -f %m $cache_file 2>/dev/null)
        set now (date +%s)
        if test -n "$cache_mtime"; and test (math $now - $cache_mtime) -lt 60
            set needs_refresh false
            set usage_data (cat $cache_file)
        end
    end

    if $needs_refresh
        set token (/usr/bin/security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
        if test -z "$token"
            set creds_path $HOME/.claude/.credentials.json
            if test -f $creds_path
                set token (jq -r '.claudeAiOauth.accessToken // empty' $creds_path 2>/dev/null)
            end
        end

        if test -n "$token"
            set response (curl -s --max-time 5 \
                -H "Accept: application/json" \
                -H "Authorization: Bearer $token" \
                -H "anthropic-beta: oauth-2025-04-20" \
                -H "User-Agent: claude-code/2.1.34" \
                "https://api.anthropic.com/api/oauth/usage" 2>/dev/null)
            if test -n "$response"; and echo $response | jq . >/dev/null 2>&1
                set usage_data $response
                echo $response > $cache_file
            end
        end

        if test -z "$usage_data"; and test -f $cache_file
            set usage_data (cat $cache_file)
        end
    end

    if test -z "$usage_data"
        echo "No usage data available."
        return 1
    end

    set cur_pct  (echo $usage_data | jq -r '.five_hour.utilization  // empty' | awk '{printf "%.0f", $1}')
    set week_pct (echo $usage_data | jq -r '.seven_day.utilization  // empty' | awk '{printf "%.0f", $1}')
    set ANTHROPIC_ORANGE D4612C

    # bg/fg colors based on utilization percentage
    function _cst_bg
        set pct $argv[1]
        if test $pct -ge 85
            echo red
        else if test $pct -ge 70
            echo bryellow   # renders as orange in most terminals
        else if test $pct -ge 50
            echo yellow
        else
            echo green
        end
    end

    function _cst_fg
        set pct $argv[1]
        if test $pct -ge 85
            echo white
        else
            echo black
        end
    end

    # Load bobthefish glyphs/colors so segment helpers work
    __bobthefish_glyphs
    __bobthefish_colors $theme_color_scheme

    # __bobthefish_start_segment / __bobthefish_finish_segments read __bobthefish_current_bg
    # from the caller's scope via the -S flag — set it here.
    set -l __bobthefish_current_bg

    echo -n " "  # leading space before first segment

    # Label segment: Anthropic brand orange
    __bobthefish_start_segment $ANTHROPIC_ORANGE white --bold
    echo -ns "claude"

    # 5h segment
    if test -n "$cur_pct"
        __bobthefish_start_segment (_cst_bg $cur_pct) (_cst_fg $cur_pct)
        echo -ns "5h: $cur_pct%"
    end

    # 7d segment
    if test -n "$week_pct"
        __bobthefish_start_segment (_cst_bg $week_pct) (_cst_fg $week_pct)
        echo -ns "7d: $week_pct%"
    end

    # cache indicator: dim trailing segment
    if $needs_refresh
        __bobthefish_start_segment black brblack
        echo -ns "live"
    else
        __bobthefish_start_segment black brblack
        echo -ns "cached"
    end

    __bobthefish_finish_segments
    echo

    functions --erase _cst_bg _cst_fg
end
