#!/usr/bin/env fish

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set -x PATH $HOME/.local/bin $HOME/.emacs.d/bin /var/lib/snapd/snap/bin /home/gergelyorosz/.asdf/installs/rust/stable/bin $PATH

set -xg STEW_HOME $HOME/Devel/Work/stew

set -xg SCB $STEW_HOME/projects/scb-master/source/scb

set -xg NNX $STEW_HOME/projects/nnx/source/nnx
set -xg ZTS $STEW_HOME/projects/scb-master/source/zts/src
set -xg TESTDB $STEW_HOME/projects/scb-master/source/scb/tests/zts/testdb-packages
set -xg PYLINTCHECKERS $STEW_HOME/projects/scb-master/source/scb/nnx-scb/pylintcheckers


set -xg PYTHONPATH $NNX $PYTHONPATH
set -xg PYTHONPATH $ZTS $PYTHONPATH
set -xg PYTHONPATH $TESTDB $PYTHONPATH

set -x ERL_AFLAGS "-kernel shell_history enabled"

set -xg HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
set -xg HOMEBREW_CELLAR /home/linuxbrew/.linuxbrew/Cellar
set -xg HOMEBREW_REPOSITORY /home/linuxbrew/.linuxbrew/Homebrew
set -xg PATH /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin $PATH
set -xg MANPATH /home/linuxbrew/.linuxbrew/share/man $MANPATH
set -xg INFOPATH /home/linuxbrew/.linuxbrew/share/info $INFOPATH

set -xg EDITOR "emacsclient --no-wait"

# if test -n "$DESKTOP_SESSION"
#     set (gnome-keyring-daemon --start | string split "=")
# end

# pyenv init - | source
source ~/.asdf/asdf.fish
