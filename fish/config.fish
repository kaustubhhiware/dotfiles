. ~/.config/fish/aliases.fish

set fish_greeting ""

set -g -x PATH /usr/local/bin $PATH
eval (thefuck --alias | tr '\n' ';')

# show system details at terminal start
# sudo apt-get install screenfetch
screenfetch 

# modify notifyre compatibility
# . ~/.notifyre.sh
# . ~/.bash-preexec.sh
