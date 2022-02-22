function full_reindex -d 'Check full reindex progress'
    # Source: redacted

    kubectl get --no-headers pod | grep --color=never batch-publish-for-full-reindex | head -1 | gawk '{print $1}' | xargs -I{} kubectl logs --since=2m {} | tail | rg "progress update" | head -1 | jq .
end
