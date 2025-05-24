function kpodname -d 'copy name of first pod matching regex to clipboard'
    set project (gcloud config get project)
    kubectl -n $project get pods | grep $argv | head -n 1 | cut -d ' ' -f 1 | pbcopy
end
