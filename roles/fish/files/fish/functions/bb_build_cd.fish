#!/usr/bin/env fish

function bb_build_cd --descripion "Build a cdrom.iso from current branch"
    cd $HOME/Devel/Balabit/build_tmp
    sudo rm -rf build
    sudo $HOME/Devel/Balabit/stew/projects/scb-master/source/scb/buildscripts/cdrom.py
end
