#!/usr/bin/env fish

function bb_build_docker_image --description "Build docker image tgz from branch"
    cd $HOME/Devel/Balabit/build_tmp
    $HOME/Devel/Balabit/stew/projects/scb-master/source/scb/buildscripts/quick-build-firmware -n core-docker -o .
    docker import  core-docker/image.tar scb
end
