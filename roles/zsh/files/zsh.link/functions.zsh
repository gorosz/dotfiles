# Useful functions

pretty_print() { echo -e "\e[1;32m$1\e[0m"; }
echo_red() { echo -e "\e[91m\e[1m$1\e[0m"; }
echo_green() { echo -e "\e[92m\e[1m$1\e[0m"; }
echo_header() { echo -e "\e[1;4m$1\e[0m"; }

to_iso() {
    local epoch=$1
    date -d @$epoch
}

to_epoch() {
    local d=${1:-`date +%Y-%m-%d`}
    echo $d
    date --date=$d +%s
}

check_sha256() {
    local check_sum="$1"
    local file=$2
    sha256_digest=`sha256sum ${file} | awk '{print $1}'`
    echo_header "Comparing sha256 sums"
    if [ $check_sum = "$sha256_digest" ]; then
        echo_green "OK"
    else
        echo_red "Checksum mismatch"
    fi
}

restart_sshagent() {
    eval $(ssh-agent) > /dev/null
}

grep_and_open() {
    local QUERY_STRING=$1
    git grep -i "$QUERY_STRING" | \
        fzf | \
        awk '{split($0,a,":");print a[1]}' | \
        xargs -I% --no-run-if-empty emacsclient --tty --no-wait %
}

ikill_process_preview() {
    local pid=$1
    echo $pid
    cat /proc/$pid/status
}

ikill() {
    local FZF_HEADER="Choose a process to kill"
    local FZF_PROMPT=": "
    local FZF_PREVIEW_COMMAND="echo '{}' | sed 's/^\s\s*/;/g' | cut -d' ' -f1 | sed 's/;//g' | xargs -I '%' --no-run-if-empty cat /proc/%/status "
    ps -eo pid,user,comm | \
        fzf --exact --multi --border --reverse --color=16 \
            --preview=$FZF_PREVIEW_COMMAND \
            --preview-window='right:hidden' \
            --bind '?:toggle-preview' \
            --prompt=$FZF_PROMPT --header=$FZF_HEADER  --header-lines=1 | \
        awk '{print $1}' | \
        xargs --no-run-if-empty kill -9
}

take() {
    local dir_to_create="$1"
    mkdir -p $dir_to_create
    cd $dir_to_create
}

clean_ssh() {
    local user="$1"
    local dest_ip="$2"
    local command="$3"
    ssh-keygen -R $dest_ip
    ssh-keyscan >> $HOME/.ssh/know_hosts
    ssh $user@$dest_ip -t $command
}

start_in_the_background() {
    local app=$@
    $app >> "/tmp/$app-run.log" 2>&1 &
}

emacs_service() {
	local command="$1"
	systemctl --user $command emacs.service
}

fbr() {
	local branches branch
  	branches=$(git branch --all | grep -v HEAD) &&
  	branch=$(echo "$branches" |
   	       fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  	git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

vmpa() {
    asdf plugin-list-all |
        fzf --multi --reverse --header="Plugin to install: " |
        xargs --no-run-if-empty -I % asdf plugin-add %
}

vmi() {
    local lang=${1}

    if [[ ! $lang ]]; then
        lang=$(asdf plugin-list | fzf)
    fi

    if [[ $lang ]]; then
        local versions=$(asdf list-all $lang | fzf -m)
        if [[ $versions ]]; then
            for version in $(echo $versions);
            do; asdf install $lang $version; done;
        fi
    fi
}


extract() {
	local remove_archive
	local success
	local extract_dir

	if (( $# == 0 )); then
		cat <<-'EOF' >&2
			Usage: extract [-option] [file ...]

			Options:
			    -r, --remove    Remove archive after unpacking.
		EOF
	fi

	remove_archive=1
	if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
		remove_archive=0
		shift
	fi

	while (( $# > 0 )); do
		if [[ ! -f "$1" ]]; then
			echo "extract: '$1' is not a valid file" >&2
			shift
			continue
		fi

		success=0
		extract_dir="${1:t:r}"
		case "$1" in
			(*.tar.gz|*.tgz) (( $+commands[pigz] )) && { pigz -dc "$1" | tar xv } || tar zxvf "$1" ;;
			(*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
			(*.tar.xz|*.txz)
				tar --xz --help &> /dev/null \
				&& tar --xz -xvf "$1" \
				|| xzcat "$1" | tar xvf - ;;
			(*.tar.zma|*.tlz)
				tar --lzma --help &> /dev/null \
				&& tar --lzma -xvf "$1" \
				|| lzcat "$1" | tar xvf - ;;
			(*.tar) tar xvf "$1" ;;
			(*.gz) (( $+commands[pigz] )) && pigz -d "$1" || gunzip "$1" ;;
			(*.bz2) bunzip2 "$1" ;;
			(*.xz) unxz "$1" ;;
			(*.lzma) unlzma "$1" ;;
			(*.Z) uncompress "$1" ;;
			(*.zip|*.war|*.jar|*.sublime-package|*.ipsw|*.xpi|*.apk) unzip "$1" -d $extract_dir ;;
			(*.rar) unrar x -ad "$1" ;;
			(*.7z) 7za x "$1" ;;
			(*.deb)
				mkdir -p "$extract_dir/control"
				mkdir -p "$extract_dir/data"
				cd "$extract_dir"; ar vx "../${1}" > /dev/null
				cd control; tar xzvf ../control.tar.gz
				cd ../data; extract ../data.tar.*
				cd ..; rm *.tar.* debian-binary
				cd ..
			;;
			(*)
				echo "extract: '$1' cannot be extracted" >&2
				success=1
			;;
		esac

		(( success = $success > 0 ? $success : $? ))
		(( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
		shift
	done
}

find_and_open() {
    local find_what="$1"
    find . -iname "*$find_what*" | fzf --reverse --header="File to open" | xargs -I "%" --no-run-if-empty $EDITOR %
}

update_doom() {
	echo_header "Upgrading DOOM and packages"
	echo_green "Updating DOOM"
    doom upgrade
    echo_green "Updating packages"
    doom update
    echo_green "Clean up"
    doom clean
    echo_green "Refreshing doom config"
    doom refresh
}
