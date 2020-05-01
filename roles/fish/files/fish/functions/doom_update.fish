#!/usr/bin/env fish

function doom_update --description "Update and refresh doom"
    doom upgrade
    doom update --insecure
    doom clean
    doom refresh
end
