function unlock -d 'resolve forced cancel of install'
    sudo rm -rf /var/lib/dpkg/lock
end
