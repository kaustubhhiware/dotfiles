function s -d 'alias for stern colored display'
    set project (gcloud config get project)
    stern --color always --exclude-container '(istio-proxy|oauth2-proxy|istio-init)' -n $project $argv
end
