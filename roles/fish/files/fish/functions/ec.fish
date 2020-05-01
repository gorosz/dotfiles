#!/usr/bin/env fish

function ec --description 'Edit file in emacs'
    emacsclient --no-wait $argv
end
