function s -d 'alias for stern colored display'
    stern --color always --exclude-container '(istio-proxy|oauth2-proxy|istio-init)' $argv
end
