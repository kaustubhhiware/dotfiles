# date regex, customised - refer http://www.adminschoice.com/unix-date-format-examples
# complicated matter,since I don't need timezone
set -g theme_date_timezone (readlink /etc/localtime | string replace '/var/db/timezone/zoneinfo/' '')
set -g theme_date_format "+%a %d %B %Y %l:%M %p"

set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin
fish_add_path --prepend /usr/local/bin


set -x NVM_DIR $HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && bash "$NVM_DIR/nvm.sh" # This loads nvm

# folder abbreviations
abbr --add mia redacted
abbr --add pp redacted
abbr --add k8 redacted
abbr --add tf redacted
abbr --add plat redacted

abbr --add gb git branch
abbr --add gd git diff

fzf --fish | source
zoxide init fish | source
thefuck --alias | source
