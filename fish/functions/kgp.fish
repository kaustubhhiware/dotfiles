function kgp -d 'alias for `kubectl get pods`'
    set project (gcloud config get project)
    kubectl -n $project get pods $argv
end
