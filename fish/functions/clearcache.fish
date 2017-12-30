function clearcache -d 'clear pagecache, dentries and inodes'
    # https://www.tecmint.com/clear-ram-memory-cache-buffer-and-swap-space-on-linux/
    # https://unix.stackexchange.com/questions/90760/how-to-reduce-buffers-cache

    echo 3 | sudo tee /proc/sys/vm/drop_caches
end
