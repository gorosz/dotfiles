#!/usr/bin/env fish

function stew_up --description 'Start stew docker container'
    set docker_image "docker.balabit/scb/stew-bionic-devel"
    pushd (pwd)

    command docker rmi --force $docker_image
    command docker pull $docker_image
    cd $HOME/Devel/Work/scb-tools/docker
    command docker-compose run --rm stew-bionic
    popd
end
