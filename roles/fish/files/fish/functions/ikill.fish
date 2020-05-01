#!/usr/bin/env fish

function ikill --description "use fzf to create UI for ps"
    ps aux | fzf --reverse --multi --header-lines=1 | awk '{print $2}' | xargs --no-run-if-empty -I% kill -9 %
end
