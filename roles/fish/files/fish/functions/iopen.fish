#!/usr/bin/env fish

function iopen --description "Use fzf to interactively open files with emacs"
    fzf --reverse | xargs --no-run-if-empty -I% emacsclient --tty --no-wait %
end
