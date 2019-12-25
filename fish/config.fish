# date regex, customised - refer http://www.adminschoice.com/unix-date-format-examples
# complicated matter,since I don't need timezone
# set -g theme_date_format "+%A %d %B %Y %l:%M:%S %p"

set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# Anaconda
set -x PATH $PATH /usr/local/anaconda3/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /usr/local/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kaustubh/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/kaustubh/Downloads/google-cloud-sdk/path.fish.inc'; end

# mini-us setup
# source (anyenv init - fish|psub)
# set -gx PATH $PATH $HOME/.anyenv/bin
# set -x NDENV_ROOT /usr/local/bin/ndenv
# set -x PATH $PATH $NDENV_ROOT
# Might have to switch to zsh :/
