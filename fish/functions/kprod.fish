function kprod -d 'checkout prod env for project'
    gcloud config set project project-name-prod
    gcloud container clusters get-credentials cluster-name-prod --project project-prod --region asia-northeast1
    kubectl config use-context super-complicated-context-prod_asia-northeast1_project-prod-tokyo-01
    kubectl get pods -n $project-name-prod --context super-complicated-context-prod_asia-northeast1_project-prod-tokyo-01
end
