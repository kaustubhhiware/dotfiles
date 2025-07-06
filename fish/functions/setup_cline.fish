function setup_cline -d 'setup cline gcp'
    gcloud auth application-default login
    gcloud auth login
    gcloud config set project gcp-personal-project
end
