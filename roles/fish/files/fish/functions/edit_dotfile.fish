#!/usr/bin/env fish

function edit_dotfile --description 'Open the selected role in dired in emacs'
    set dotfiles_repo_dir $HOME/Devel/Mine/dotfiles
    set roles_dir $dotfiles_repo_dir/roles
    command lsd -1 $roles_dir | fzf --reverse --header="Ansible Role to edit" | xargs --no-run-if-empty --replace=% emacsclient --no-wait $roles_dir/%
end
