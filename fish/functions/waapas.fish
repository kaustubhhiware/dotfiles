# customised function to perform reboot
function waapas -d 'reboot securely'
    sudo pkill mopidy
    sudo reboot
end
