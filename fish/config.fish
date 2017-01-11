. ~/.config/fish/aliases.fish

set -g -x PATH /usr/local/bin $PATH
eval (thefuck --alias | tr '\n' ';')

# modify notifyre compatibility
# . ~/.notifyre.sh
# . ~/.bash-preexec.sh
