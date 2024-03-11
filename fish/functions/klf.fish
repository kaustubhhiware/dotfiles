function klf -d 'alias for `kubectl logs -f`'
    set project (gcloud config get project)
    kubectl -n $project logs -f $argv
end
