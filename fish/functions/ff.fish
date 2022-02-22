function ff -d 'alias for `go test -failfast`'
    go test -failfast ./... -parallel 32 -count=1
end
