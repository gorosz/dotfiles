#!/usr/bin/env fish

function take --description 'Create and cd into a directory'
    mkdir -p $argv
    cd $argv
end
