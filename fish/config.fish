# refer https://github.com/jbucaran/fish-shell-cookbook
# all aliases moved to functions/

set -gx PATH /usr/local/bin $PATH
eval (thefuck --alias | tr '\n' ';')

# see fish_greeting.fish

# date regex, customised - refer http://www.adminschoice.com/unix-date-format-examples
# complicated matter,since I don't need timezone
# set -g theme_date_format "+%A %d %B %Y %l:%M:%S %p"

# want your name ? uncomment the below line
# set -U theme_title_display_user yes
set -U theme_nerd_fonts no

# pintos
# set -gx PATH $PATH /home/kaustubh/os-pintos/pintos/src/utils
set -gx SLACK_TOKEN 'xoxp-10602205079-71416117799-166757221188-99650113a39058538b8b04e7edc290df'

# gradle, for DBMS
# set -gx PATH $PATH /opt/gradle/gradle-3.5/bin

# robomongo
# set -gx PATH $PATH /usr/local/bin/robomongo/bin
 
# set -gx NODE_PATH /home/kaustubh/node_modules
# set -gx PATH $PATH $NODE_PATH

# tilix wanted this
# source /etc/profile.d/vte.sh

xrdb ~/.XResources

# fonts
# source ~/.local/share/icons-in-terminal/icons.fish
# source ~/.fonts/*.sh

# fix for "WARNING **: Couldn't connect to accessibility bus: Failed to connect to socket /tmp/dbus-lUmi6jE2KK:"
set -gx NO_AT_BRIDGE 1

# tensorflow
#set -gx LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/your/local/cuda/lib64"

# torch
# ? means one char only
# set -gx LUA_PATH /home/kaustubh/.luarocks/share/lua/5.1/?.lua;/home/kaustubh/.luarocks/share/lua/5.1/?/init.lua;/home/kaustubh/torch/install/share/lua/5.1/?.lua;/home/kaustubh/torch/install/share/lua/5.1/?/init.lua;./?.lua;/home/kaustubh/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
# set -gx LUA_CPATH='/home/kaustubh/.luarocks/lib/lua/5.1/?.so;/home/kaustubh/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'

# miniconda
# set -gx PATH $PATH /home/kaustubh/miniconda3/bin /home/kaustubh/torch/install/bin

# set -gx PATH $PATH /home/kaustubh/torch/install/bin
# set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH /home/kaustubh/torch/install/lib
# set -gx DYLD_LIBRARY_PATH $DYLD_LIBRARY_PATH /home/kaustubh/torch/install/lib
# set -gx LUA_CPATH $LUA_CPATH '/home/kaustubh/torch/install/lib/?.so;'

# for cava gradient, need this for xfce4-terminal
# if [ "$COLORTERM" = "xfce4-terminal" ] 
#     export TERM=xterm-256color
# end

# pod2man, pacaur
set -gx PATH $PATH /usr/bin/core_perl

# set the irritating xfce beep off
xset b off

# use ruby gems
set -gx PATH $PATH /home/kaustubh/.gem/ruby/2.5.0/bin

# node and npm
set -gx PATH $PATH /usr/lib/node_modules
