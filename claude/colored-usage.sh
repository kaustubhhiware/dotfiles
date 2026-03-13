#!/usr/bin/env bash
# Claude usage statusline — bobthefish powerline style (matches cst.fish)

if [ -t 0 ]; then input=""; else input=$(cat 2>/dev/null); fi
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty' 2>/dev/null | awk '{printf "%.0f", $1}')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty' 2>/dev/null)
[ -z "$cwd" ] && cwd=$(pwd)

# Git branch + status
git_branch=""
git_dirty=false
git_ahead=false
if git -C "$cwd" rev-parse --is-inside-work-tree --no-optional-locks 2>/dev/null | grep -q true; then
  git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
               || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ] && git_dirty=true
  ahead=$(git -C "$cwd" --no-optional-locks rev-list "@{u}..HEAD" --count 2>/dev/null)
  [ -n "$ahead" ] && [ "$ahead" -gt 0 ] 2>/dev/null && git_ahead=true
fi

# Usage cache + API fetch
cache_file="/tmp/claude/statusline-usage-cache.json"
mkdir -p /tmp/claude
cur_pct=""
week_pct=""
usage_data=""
needs_refresh=true

if [ -f "$cache_file" ]; then
  cache_mtime=$(stat -f %m "$cache_file" 2>/dev/null)
  now=$(date +%s)
  if [ -n "$cache_mtime" ] && [ $(( now - cache_mtime )) -lt 60 ]; then
    needs_refresh=false
    usage_data=$(cat "$cache_file")
  fi
fi

if $needs_refresh; then
  token=""
  keychain_raw=$(/usr/bin/security find-generic-password -s "Claude Code-cBG_REDentials" -w 2>/dev/null)
  if [ -n "$keychain_raw" ]; then
    token=$(echo "$keychain_raw" | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
    if [ -z "$token" ] && echo "$keychain_raw" | grep -qE '^[A-Za-z0-9_\-\.]+$'; then
      token="$keychain_raw"
    fi
  fi
  if [ -z "$token" ]; then
    cBG_REDs_path="$HOME/.claude/.cBG_REDentials.json"
    if [ -f "$cBG_REDs_path" ]; then
      token=$(jq -r '.claudeAiOauth.accessToken // empty' "$cBG_REDs_path" 2>/dev/null)
    fi
  fi
  if [ -z "$token" ]; then
    while IFS= read -r svc_name; do
      [ -z "$svc_name" ] && continue
      raw=$(/usr/bin/security find-generic-password -s "$svc_name" -w 2>/dev/null)
      [ -z "$raw" ] && continue
      t=$(echo "$raw" | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
      if [ -z "$t" ] && echo "$raw" | grep -qE '^[A-Za-z0-9_\-\.]+$'; then t="$raw"; fi
      if [ -n "$t" ]; then token="$t"; break; fi
    done < <(/usr/bin/security dump-keychain 2>/dev/null \
              | grep '"svce"' | grep -i 'claude' | awk -F'"' '{print $4}' | grep -v "^Claude Code-cBG_REDentials$")
  fi
  if [ -n "$token" ]; then
    response=$(curl -s --max-time 5 \
      -H "Accept: application/json" \
      -H "Authorization: Bearer $token" \
      -H "anthropic-beta: oauth-2025-04-20" \
      -H "User-Agent: claude-code/2.1.34" \
      "https://api.anthropic.com/api/oauth/usage" 2>/dev/null)
    if [ -n "$response" ] && echo "$response" | jq -e '.five_hour // .seven_day' >/dev/null 2>&1; then
      usage_data="$response"
      echo "$response" > "$cache_file"
    fi
  fi
  [ -z "$usage_data" ] && [ -f "$cache_file" ] && usage_data=$(cat "$cache_file")
fi

if [ -n "$usage_data" ]; then
  cur_pct=$(echo "$usage_data"  | jq -r '.five_hour.utilization // empty' | awk '{printf "%.0f", $1}')
  week_pct=$(echo "$usage_data" | jq -r '.seven_day.utilization // empty' | awk '{printf "%.0f", $1}')
fi

# Colors — $'\xNN' hex escapes work on bash 3.2 (macOS default)
R=$'\033[0m'
ARROW=$'\xee\x82\xb0'  # U+E0B0 powerline right-pointing solid arrow

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
FG_RED=$'\033[38;5;9m'         BG_RED=$'\033[48;5;9m'
FG_ORANGE=$'\033[38;5;208m' BG_ORANGE=$'\033[48;5;208m'
FG_YELLOW=$'\033[38;5;178m' BG_YELLOW=$'\033[48;5;178m'
FG_GREEN=$'\033[38;5;114m'   BG_GREEN=$'\033[48;5;114m'
FG_BRANCH=$'\033[38;5;148m' BG_BRANCH=$'\033[48;5;148m'  # bobthefish branch color
FG_WHITE=$'\033[97m'
FG_BLACK=$'\033[30m'
BG_BLACK=$'\033[48;5;16m'
BG_GRAY=$'\033[48;5;244m'
BG_WHITE=$'\033[48;5;15m'

pct_bg()  {
  local p=$1
  if   [ "$p" -ge 85 ]; then echo "$BG_RED"
  elif [ "$p" -ge 70 ]; then echo "$BG_ORANGE"
  elif [ "$p" -ge 50 ]; then echo "$BG_YELLOW"
  else                        echo "$BG_GREEN"
  fi
}
pct_afg() {
  local p=$1
  if   [ "$p" -ge 85 ]; then echo "$FG_RED"
  elif [ "$p" -ge 70 ]; then echo "$FG_ORANGE"
  elif [ "$p" -ge 50 ]; then echo "$FG_YELLOW"
  else                        echo "$FG_GREEN"
  fi
}
pct_tfg() { if [ "$1" -ge 85 ]; then echo "$FG_WHITE"; else echo "$FG_BLACK"; fi; }

# Segment arrays: bg, arrow-fg, text-fg, content
declare -a S_BG S_AFG S_TFG S_CON

add_seg() { S_BG+=("$1"); S_AFG+=("$2"); S_TFG+=("$3"); S_CON+=("$4"); }

# commented out: colored bgs too
if [ -n "$git_branch" ]; then
  git_content="$git_branch"
  if $git_dirty; then
    git_bg="$BG_RED"; git_afg="$BG_RED"; git_tfg="$FG_WHITE"
  else
    git_bg="$BRANCH"; git_afg="$BRANCH"; git_tfg="$FG_BLACK"
    $git_ahead && git_content="${git_branch} +"
  fi
  add_seg "$git_bg" "$git_afg" "$git_tfg" "⎇ $git_content"
fi

# commented out: colored bgs too
# [ -n "$ctx_pct"  ] && add_seg "$(pct_bg "$ctx_pct")"  "$(pct_afg "$ctx_pct")"  "$(pct_tfg "$ctx_pct")"  "ctx: ${ctx_pct}%"
# [ -n "$cur_pct"  ] && add_seg "$(pct_bg "$cur_pct")"  "$(pct_afg "$cur_pct")"  "$(pct_tfg "$cur_pct")"  "5h: ${cur_pct}%"
# [ -n "$week_pct" ] && add_seg "$(pct_bg "$week_pct")" "$(pct_afg "$week_pct")" "$(pct_tfg "$week_pct")" "7d: ${week_pct}%"
# # Render: leading space, then each segment (arrow between consecutive segments)
# out=" "
# prev_afg=""
# for i in "${!S_CON[@]}"; do
#   bg="${S_BG[$i]}"  afg="${S_AFG[$i]}"  tfg="${S_TFG[$i]}"  con="${S_CON[$i]}"
#   [ -n "$prev_afg" ] && out+="${bg}${prev_afg}${ARROW}"
#   out+="${bg}${tfg} ${con} "
#   prev_afg="$afg"
# done

# # Trailing arrow back to terminal default bg
# [ -n "$prev_afg" ] && out+="${R}${prev_afg}${ARROW}${R}"

# alt: colored fg, bg is monokai
[ -n "$ctx_pct"  ] && add_seg "$BG_BLACK"  "$BG_BLACK"  "$(pct_afg "$ctx_pct")"  "ctx: ${ctx_pct}%"
[ -n "$cur_pct"  ] && add_seg "$BG_BLACK"  "$BG_BLACK"  "$(pct_afg "$cur_pct")"  "5h: ${cur_pct}%"
[ -n "$week_pct" ] && add_seg "$BG_BLACK" "$BG_BLACK" "$(pct_afg "$week_pct")" "7d: ${week_pct}%"

# Render: leading space, then each segment (arrow between consecutive segments)
out=""
prev_afg=""
for i in "${!S_CON[@]}"; do
  bg="${S_BG[$i]}"  afg="${S_AFG[$i]}"  tfg="${S_TFG[$i]}"  con="${S_CON[$i]}"
  [ -n "$prev_afg" ] && out+="${bg}${$BG_BLACK}${ARROW}"
  out+="${bg}${tfg} ${con} "
  prev_afg="$afg"
done

# Trailing arrow back to terminal default bg
[ -n "$prev_afg" ] && out+="${R}${$BG_BLACK}${ARROW}${R}"

printf "%s\n" "$out"
exit 0
