#!/usr/bin/env fish

function stew_up --description 'Start stew docker container'
    set docker_image "docker.balabit/scb/stew-bionic-devel"
    pushd (pwd)

    if test (docker images | grep "stew-bionic-devel") > /dev/null
        command docker rmi --force $docker_image
        command docker pull $docker_image
    end
    cd $HOME/Devel/Balabit/scb-tools/docker
    command docker-compose run --rm stew-bionic
    popd
end
