
next() {
    run_player_command next
}

prev() {
    run_player_command previous
}

pp() {
    run_player_command play-pause
}

run_player_command() {
    local command spotify
    command=$1
    spotify="/usr/bin/playerctl --player=spotify"
    eval ${spotify} $command
}
