# Docker related functions and aliases

XARGS_BIN="xargs --no-run-if-empty"

docker_clean() {
    echo 'Removing containers'
    docker rm -f $(docker ps -a -q)
    echo 'Removing images'
    docker rmi -f $(docker images -q)
    echo "Removing local volumes"
    docker volume ls -q | $XARGS_BIN docker volume rm
}

docker_remove_none() {
    docker images | grep '^<none>' | awk '{print $3}' | $XARGS_BIN docker rmi -f
}

docker_remove_containers() {
    docker ps -aq | $XARGS_BIN docker rm -f
}

docker_remove_images() {
    docker images -q | $XARGS_BIN docker rmi -f
}

docker_remove_volumes() {
    docker volume ls -a | $XARGS_BIN docker volume rm
}

docker_remove_none_tags() {
    docker images | awk '{print $2, $3}' | grep '^<none>' | awk '{print $2}' | $XARGS_BIN docker rmi
}

f_select_docker_image() {
    docker images |
        fzf --header-lines=1 --reverse |
        awk '{print $3}' |
        xargs --no-run-if-empty echo
}

f_select_docker_container() {
    docker ps -a |
        fzf --header-lines=1 --reverse --multi |
        awk '{print $1}' |
        xargs --no-run-if-empty echo
}

docker_delete_image() {
    local image_id=$(f_select_docker_image)
    echo "Image id: " $image_id
    docker rmi -f $image_id
}

docker_delete_container() {
    local cont_id=$(f_select_docker_container)
    echo "Container id: " $cont_id
    docker rm -f $cont_id
}

# docker aliases
alias ddi='docker_delete_image'
alias ddc='docker_delete_container'
alias dim='docker images'
alias dl='docker logs'
alias dlf='docker logs -f'
alias docker_start='sudo systemctl start docker'
alias dps='docker ps -a'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dr='docker'
alias drm='docker rm -f'
alias drma='docker_remove_containers'
alias drmi='docker rmi -f'
alias drmia='docker_remove_images'
alias drn='docker_remove_none'
alias dsrm='docker_stop_and_remove'
alias dsw='docker_start_and_logs'
alias dvl='docker volume ls'
alias dvrm='docker volume rm'
alias dvrma='docker_remove_volumes'
