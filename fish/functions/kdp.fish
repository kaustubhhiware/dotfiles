function kdp -d 'alias for `kubectl describe pods`'
    set project (gcloud config get project)
    kubectl -n $project describe pods $argv
end
