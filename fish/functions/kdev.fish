function kdev -d 'checkout dev env for item attributes'
    gcloud config set project kouzoh-item-attributes-jp-dev
    gcloud container clusters get-credentials citadel-2g-dev-tokyo-01 --project mercari-jp-citadel-dev --region asia-northeast1
    kubectx gke_mercari-jp-citadel-dev_asia-northeast1_citadel-2g-dev-tokyo-01
    kubectl get pods -n kouzoh-item-attributes-jp-dev
end
