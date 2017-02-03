# make functions, not aliases
# source - https://github.com/jbucaran/fish-shell-cookbook
#. ~/.config/fish/functions
# all aliases moved to functions/

set -g -x PATH /usr/local/bin $PATH
eval (thefuck --alias | tr '\n' ';')
# show system details at terminal start
# sudo apt-get install screenfetch
screenfetch

# modify notifyre compatibility
# . ~/.notifyre.sh
# . ~/.bash-preexec.sh
