function podroll -d 'adds podcast image before and after audiogram for branding'
    set filename (echo $argv | cut -d '.' -f1)
    ffmpeg -loop 1 -framerate 24 -t 1 -i ../../branding/pod-cover-640.png -t 1 -f lavfi -i aevalsrc=0 -i $argv -loop 1 -framerate 24 -t 3 -i ../../branding/pod-cover-640.png \
        -t 3 -f lavfi -i aevalsrc=0 \
        -filter_complex '[0:0] [1:0] [2:0] [2:1] [3:0] [4:0] concat=n=3:v=1:a=1' \
        "$filename-out.mp4"
end
