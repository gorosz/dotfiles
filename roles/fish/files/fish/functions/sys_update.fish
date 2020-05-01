#!/usr/bin/env fish

function sys_update --description "Run dnf upgrade, doom upgrade and flatpak upadte"
    echo "Running system update with sudo"
    sudo dnf upgrade
    echo "Update flatpaks"
    flatpak update
    echo "Updating doom emacs"
    $HOME/.emacs.d/bin/doom upgrade
end
