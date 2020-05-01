#!/usr/bin/env fish

function dckr_rm --description "fzf interface for docker rm"
    docker ps -a | fzf --reverse --header-lines 1 --multi | awk '{print $1}' | xargs --no-run-if-empty -I% docker rm -f %
end
