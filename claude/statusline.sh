#!/usr/bin/env bash
# Claude Code statusline — bobthefish-style
# dir | git branch | model | ctx:X% | cur:X% | week:X%

input=$(cat)

# --- Claude Code fields ---
cwd=$(echo "$input"   | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
window_used=$(echo "$input"  | jq -r '.context_window.used_percentage // empty')

# --- Usage limits (5-hour current + 7-day weekly) via cached API ---
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
  # --- Resolve OAuth access token ---
  # The Keychain value may be JSON ({ "claudeAiOauth": { "accessToken": "..." } })
  # or a plain bearer token string (newer Claude Code versions).
  token=""
  keychain_raw=$(/usr/bin/security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null)
  if [ -n "$keychain_raw" ]; then
    # Try JSON parse first
    token=$(echo "$keychain_raw" | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
    # If empty and raw value looks like a bearer token, use it directly
    if [ -z "$token" ] && echo "$keychain_raw" | grep -qE '^[A-Za-z0-9_\-\.]+$'; then
      token="$keychain_raw"
    fi
  fi

  # Fallback: ~/.claude/.credentials.json
  if [ -z "$token" ]; then
    creds_path="$HOME/.claude/.credentials.json"
    if [ -f "$creds_path" ]; then
      token=$(jq -r '.claudeAiOauth.accessToken // empty' "$creds_path" 2>/dev/null)
    fi
  fi

  # Fallback: scan for other Claude Code Keychain entries (per-account service names)
  if [ -z "$token" ]; then
    while IFS= read -r svc_name; do
      [ -z "$svc_name" ] && continue
      raw=$(/usr/bin/security find-generic-password -s "$svc_name" -w 2>/dev/null)
      [ -z "$raw" ] && continue
      t=$(echo "$raw" | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
      if [ -z "$t" ] && echo "$raw" | grep -qE '^[A-Za-z0-9_\-\.]+$'; then
        t="$raw"
      fi
      if [ -n "$t" ]; then token="$t"; break; fi
    done < <(/usr/bin/security dump-keychain 2>/dev/null \
              | grep '"svce"' | grep -i 'claude' | awk -F'"' '{print $4}' | grep -v "^Claude Code-credentials$")
  fi

  if [ -n "$token" ]; then
    response=$(curl -s --max-time 5 \
      -H "Accept: application/json" \
      -H "Authorization: Bearer $token" \
      -H "anthropic-beta: oauth-2025-04-20" \
      -H "User-Agent: claude-code/2.1.34" \
      "https://api.anthropic.com/api/oauth/usage" 2>/dev/null)
    # Only cache valid usage responses — not error JSON
    if [ -n "$response" ] && echo "$response" | jq -e '.five_hour // .seven_day' >/dev/null 2>&1; then
      usage_data="$response"
      echo "$response" > "$cache_file"
    fi
  fi
  # Use old cache only if we still have no live data
  [ -z "$usage_data" ] && [ -f "$cache_file" ] && usage_data=$(cat "$cache_file")
fi

if [ -n "$usage_data" ]; then
  cur_pct=$(echo "$usage_data"  | jq -r '.five_hour.utilization // empty' | awk '{printf "%.0f", $1}')
  week_pct=$(echo "$usage_data" | jq -r '.seven_day.utilization // empty' | awk '{printf "%.0f", $1}')
fi

# --- bobthefish-style path compression ---
fish_compress_dir() {
  local raw="${1:-$(pwd)}"
  local real_home
  real_home=$(cd ~ && pwd -P 2>/dev/null)
  local tilde
  tilde=$(echo "$raw" | sed "s|^$real_home|~|")
  if [[ "$tilde" == "$raw" && -n "$HOME" ]]; then
    tilde=$(echo "$raw" | sed "s|^$HOME|~|")
  fi
  IFS='/' read -ra parts <<< "$tilde"
  local result=""
  local total=${#parts[@]}
  for (( i=0; i<total; i++ )); do
    local seg="${parts[$i]}"
    if [ -z "$seg" ]; then
      result="/"
      continue
    fi
    if [ $i -eq $(( total - 1 )) ]; then
      result="${result}${seg}"
    else
      result="${result}${seg:0:1}/"
    fi
  done
  echo "$result"
}

if [ -n "$cwd" ]; then
  short_dir=$(fish_compress_dir "$cwd")
else
  short_dir=$(fish_compress_dir "$(pwd)")
fi

# --- Git branch (fast, skip locks) ---
git_branch=""
if git -C "${cwd:-$(pwd)}" rev-parse --is-inside-work-tree --no-optional-locks 2>/dev/null | grep -q true; then
  git_branch=$(git -C "${cwd:-$(pwd)}" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
               || git -C "${cwd:-$(pwd)}" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
fi

# --- Colors (matched to bobthefish fish prompt) ---
WHITE="\033[1;37m"          # dir
BRANCH="\033[38;5;149m"     # branch — muted yellow-green
CTX="\033[38;5;117m"        # ctx    — light blue
DIM="\033[2m"               # separators
RESET="\033[0m"

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
usage_color() {
  local pct=$1
  if   [ "$pct" -ge 85 ]; then printf "\033[38;5;196m"   # red
  elif [ "$pct" -ge 70 ]; then printf "\033[38;5;215m"   # orange
  elif [ "$pct" -ge 50 ]; then printf "\033[38;5;228m"   # yellow
  else                         printf "\033[38;5;245m"   # gray
  fi
}

# --- Build output ---
out="${WHITE}📁 ${short_dir}${RESET}"

if [ -n "$git_branch" ]; then
  out="${out} ${DIM}|${RESET} ${BRANCH}🌿 ${git_branch}${RESET}"
fi

if [ -n "$model" ]; then
  out="${out} ${DIM}|${RESET} ${DIM}${model}${RESET}"
fi

if [ -n "$window_used" ]; then
  clr=$(usage_color "$window_used")
  out="${out} ${DIM}|${RESET} ${clr}ctx:${window_used}%${RESET}"
fi

if [ -n "$cur_pct" ]; then
  clr=$(usage_color "$cur_pct")
  out="${out} ${DIM}|${RESET} ${clr}cur:${cur_pct}%${RESET}"
fi

if [ -n "$week_pct" ]; then
  clr=$(usage_color "$week_pct")
  out="${out} ${DIM}|${RESET} ${clr}week:${week_pct}%${RESET}"
fi

printf "%b\n" "$out"
