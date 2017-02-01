#
# convert all aliases to functions for less load
#
function bandkar
    sudo shutdown now
end

function waapas
    sudo reboot
end

# all things git
function gst
    git status
end

function ga
    git add $argv
end

function gc
    git commit $argv
end
