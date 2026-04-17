#!/usr/bin/env bash
# This script syncs specified files and folders (with entire trees)

# BOSSMAN is system variable, containing packages installed for BOSSMAN
# These packages will be ignored in diff.
# Don't commit them to a public repo, or else BOSSMAN comes knocking.
if [ ! -n "$BOSSMAN" ]; then
    echo ">>> Error: BOSSMAN variable is empty"
    exit 1
fi


# argument to only print the diff on existing common files
STEP4_ONLY=false
if [[ "$1" == "--step4" || "$1" == "-4" ]]; then
    STEP4_ONLY=true
fi

SOURCE_DIR="$HOME"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# "src_rel:dest_rel"
FILES=(
    ".claude/AGENT_MISTAKES.md:claude/AGENT_MISTAKES.md"
    ".claude/CLAUDE.md:claude/CLAUDE.md"
    ".claude/colored-usage.sh:claude/colored-usage.sh"
    ".claude/keybindings.json:claude/keybindings.json"
    ".claude/settings.json:claude/settings.json"
    ".claude/statusline.sh:claude/statusline.sh"
    ".config/ccstatusline/settings.json:ccstatusline/settings.json"
    ".gitconfig:gitconfig"
)

FOLDERS=(
    ".claude/hooks:claude/hooks"
    ".claude/plugins:claude/plugins"
    ".claude/skills:claude/skills"
    ".config/bat:bat"
    ".config/fish:fish"
    ".config/ghostty:ghostty"
    ".config/cmux:cmux"
    ".config/raycast/scripts:raycast/scripts"
)

FOLDERS_IGNORE=(
    ".git"
    "cache"
    "marketplaces" # claude
)

# Can use .gitignore, but I want to omit at script level
IGNORE_FILES=(
    "kdev.fish"
    "kprod.fish"
    "mat.fish"
    "pat.fish"
    ".state.json" # peon
    "install-counts-cache.json" # claude
    "installed_plugins.json" # claude
    "project-memory.json" # claude
)


has_ignored_component() {
    local path="$1"
    for ignore in "${FOLDERS_IGNORE[@]}"; do
        [[ "$path" == *"/$ignore/"* ]] && return 0
    done
    return 1
}

is_ignored_file() {
    local filename
    filename=$(basename "$1")
    [[ " ${IGNORE_FILES[*]} " =~ " ${filename} " ]] && return 0
    return 1
}

# "label|source_path|dest_path|origin"  (origin: FILE or folder src_rel)
PAIRS=()

for entry in "${FILES[@]}"; do
    IFS=':' read -r src_rel dest_rel <<< "$entry"
    is_ignored_file "$src_rel" && continue
    PAIRS+=("$src_rel|$SOURCE_DIR/$src_rel|$DEST_DIR/$dest_rel|FILE")
done

for entry in "${FOLDERS[@]}"; do
    IFS=':' read -r src_rel dest_rel <<< "$entry"
    src_dir="$SOURCE_DIR/$src_rel"
    dest_dir="$DEST_DIR/$dest_rel"

    all_rels=()

    if [ -d "$src_dir" ]; then
        while IFS= read -r -d '' f; do
            has_ignored_component "$f" && continue
            is_ignored_file "$f" && continue
            all_rels+=("${f#$src_dir/}")
        done < <(find "$src_dir" -type f -print0)
    fi

    if [ -d "$dest_dir" ]; then
        while IFS= read -r -d '' f; do
            has_ignored_component "$f" && continue
            is_ignored_file "$f" && continue
            all_rels+=("${f#$dest_dir/}")
        done < <(find "$dest_dir" -type f -print0)
    fi

    while IFS= read -r rel; do
        [ -z "$rel" ] && continue
        PAIRS+=("$src_rel/$rel|$src_dir/$rel|$dest_dir/$rel|$src_rel")
    done < <(printf '%s\n' "${all_rels[@]}" | sort -u)
done

if $STEP4_ONLY; then
    echo -e "\n>> Skipping steps 1-3 (--step4 mode)"
fi

if ! $STEP4_ONLY; then

echo -e "\n>> Step 1: Synced: in Source, in Destination"
for entry in "${PAIRS[@]}"; do
    IFS='|' read -r label src dest origin <<< "$entry"
    [ "$origin" != "FILE" ] && continue
    [ -f "$src" ] && [ -f "$dest" ] && cmp -s "$src" "$dest" && echo "   [file] $label"
done
for folder_entry in "${FOLDERS[@]}"; do
    IFS=':' read -r folder_src_rel _ <<< "$folder_entry"
    all_synced=true
    any_file=false
    for entry in "${PAIRS[@]}"; do
        IFS='|' read -r label src dest origin <<< "$entry"
        [ "$origin" != "$folder_src_rel" ] && continue
        any_file=true
        if [ -f "$src" ] && [ -f "$dest" ] && cmp -s "$src" "$dest"; then
            :
        else
            all_synced=false
            break
        fi
    done
    $any_file && $all_synced && echo "   [dir]  $folder_src_rel"
done

echo -e "\n>> Step 2: in Source, not in Destination"
for entry in "${PAIRS[@]}"; do
    IFS='|' read -r label src dest origin <<< "$entry"
    if [ -f "$src" ] && [ ! -f "$dest" ]; then
        echo "   Copying: $label"
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
    fi
done

echo -e "\n>> Step 3: not in Source, in Destination"
for entry in "${PAIRS[@]}"; do
    IFS='|' read -r label src dest origin <<< "$entry"
    if [ ! -f "$src" ] && [ -f "$dest" ]; then
        echo "   Consider copying: $label"
    fi
done

fi # end !STEP4_ONLY

echo -e "\n>> Step 4: Conflict: in Source, in Destination"
for entry in "${PAIRS[@]}"; do
    IFS='|' read -r label src dest origin <<< "$entry"
    if [ -f "$src" ] && [ -f "$dest" ] && ! cmp -s "$src" "$dest"; then
        echo -e "\n   >> Different content: $label"
        diff -u "$dest" "$src" | grep -v -E "$BOSSMAN" | diff-so-fancy
    fi
done

echo -e "\n\n|> General sync script completed"
