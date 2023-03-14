function kprod -d 'checkout prod env for item attributes'
    gcloud config set project kouzoh-item-attributes-jp-prod
    # gcloud container clusters get-credentials citadel-2g-dev-tokyo-01 --project mercari-jp-citadel-dev --region asia-northeast1
    kubectx gke_mercari-jp-citadel-prod_asia-northeast1_citadel-2g-prod-tokyo-01
    kubectl get pods -n kouzoh-item-attributes-jp-prod
end
