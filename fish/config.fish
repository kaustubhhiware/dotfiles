# date regex, customised - refer http://www.adminschoice.com/unix-date-format-examples
# complicated matter,since I don't need timezone
set -g theme_date_format "+%a %d %B %Y %l:%M:%S %p"

set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kaustubh/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/kaustubh/Downloads/google-cloud-sdk/path.fish.inc'; end

# Python 3.12.2_1 runs into an error "no module named imp"
export CLOUDSDK_PYTHON=python3.10


set -x NVM_DIR $HOME/.nvm
set -x GOKOUZOH $GOPATH/src/github.com/kouzoh/

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# folder abbreviations
abbr --add mia redacted
abbr --add pp redacted
abbr --add k8 redacted
abbr --add tf redacted
abbr --add plat redacted

# abbr --add ga git add
abbr --add auth gcloud auth login
abbr --add gb git branch
abbr --add gc git commit
abbr --add gco git checkout
abbr --add gd git diff
