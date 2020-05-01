#!/usr/bin/env fish
function copy_branch_name --description "Copy the branch nem to clipboard"
    git rev-parse --abbrev-ref HEAD | tr -d '\n' | xsel -i -b -p
end
