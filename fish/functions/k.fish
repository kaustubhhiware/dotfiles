function k -d 'alias for `kubectl` with current project'
    set project (gcloud config get project)
    kubectl -n $project $argv
end
