function kdev -d 'checkout dev env for project'
    gcloud config set project project-name-dev
    gcloud container clusters get-credentials cluster-nam-dev --project project-dev --region asia-northeast1
    kubectx super-complicated-context-dev_asia-northeast1_project-dev-tokyo-01
    kubectl get pods -n $project-name-dev
end
