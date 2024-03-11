function kpf -d 'alias for `kubectl port-forward`'
    set project (gcloud config get project)
    kubectl -n $project port-forward $argv
end
