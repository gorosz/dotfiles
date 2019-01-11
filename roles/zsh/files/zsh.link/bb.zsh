STEW_HOME=$HOME/Devel/Balabit/stew
SCB_HOME=$STEW_HOME/projects/scb-master
NNX_HOME=$STEW_HOME/projects/nnx-xenial
BUILD_HOME=$HOME/tmp

build_pam_cd() {
    cd $BUILD_HOME
    for x in {1..9}
    do
        local build_folder=b$x
        if [ ! -d $build_folder ]; then
           take -p $BUILD_HOME/$build_folder
           break
        fi
    done
    source/scb/buildscripts/quick-build-firmware --cache-policy disabled
    cd -
}

build_and_upload() {
    local sps_ip
    local upload_script
    local cdrom_iso
    sps_ip=$1
    upload_script=$HOME/Devel/Balabit/scb-tools/bin/upload_scb_firmware.sh
    cdrom_iso=$SCB_HOME/build/cdmrom.is
    build_pam_cd
    $upload_script $sps_ip $cdrom_iso

}

stew_up() {
    local tools_dir="$HOME/Devel/Balabit/scb-tools/docker"
    cd $stew_dir
    docker-compose run --rm stew-bionic
}

vpn_up() {
    nmcli con up id Balabit passwd-file /home/gergelyorosz/.dotfiles/cert/vpn_pwd
}

vpn_down() {
    nmcli con down id Balabit
}

clean_scb_build() {
    cd $SCB_HOME
    sudo rm -rf build
    cd -
}

pam_int_sprint() {
    jira sprint 463
}

pam_int_todos() {
    _jira_jql 'Sprint = 463 and assignee is EMPTY and status = "TO DO" '
}

pam_int_inprogress() {
    _jira_jql 'Sprint = 463 and status = "In Progress" '
}

pam_int_review() {
    _jira_jql 'Sprint = 463 and status = "Waiting for review" '
}

pam_int_testing() {
    _jira_jql 'sprint = 463 and status = Testing '
}

pam_int_blocked() {
    _jira_jql 'sprint = 463 and status = Blocked '
}

pam_int_done() {
    _jira_jql 'sprint = 463 and status = Done '
}

pam_int_daily() {
    echo $bold_color$fg[red]Blocked${reset_color}
    pam_int_blocked
    echo $bold_color$fg[green]Done${reset_color}
    pam_int_done
    echo $bold_color$fg[cyan]Testing${reset_color}
    pam_int_testing
    echo $bold_color$fg[yellow]Waiting for review${reset_color}
    pam_int_review
    echo $bold_color$fg[blue]In progress${reset_color}
    pam_int_inprogress
}

_jira_jql() {
    local query="$1"
    local order="ORDER BY createdDate ASC"
    jira issue jql $query $order
}

jenkins() {
    java -jar $HOME/Tools/jenkins/jenkins-cli.jar -noCertificateCheck -noKeyAuth -s https://jenkins.bsp.balabit "$@"
}

jenkins2() {
    java -jar $HOME/Tools/jenkins/jenkins-cli.jar -noCertificateCheck -s https://jenkins2.scb.balabit "$@"
}

startTransaction() {
		
	if [ -z "$1" ]; then echo "please specify an address"; return 0;
	fi
	IP=$1
	curl  --digest --user admin:a --cookie-jar .session -k --basic https://$IP/api/authentication
	SESSION_ID=`cat .session | grep session_id | cut -f7`
	curl https://$IP/api/transaction --request POST -k --cookie session_id=$SESSION_ID --data ''
}

closeTransaction() {
	if [ -z "$1" ]; then echo "please specify an address"; return 0;
	fi
	IP=$1
	SESSION_ID=`cat .session | grep session_id | cut -f7`
	curl https://$IP/api/transaction --request PUT -k --cookie session_id=$SESSION_ID --data ''
	rm .session
}

uploadFile() {
	if [ -z "$1" ]; then echo "please specify an address"; return 0;
	fi
	if [ -z "$2" ]; then echo "please specify a filename"; return 0;
	fi
	IP=$1
	FILENAME=$2
	SESSION_ID=`cat .session | grep session_id | cut -f7`
	curl https://$IP/api/upload/plugins --request POST -k --cookie session_id=$SESSION_ID --upload-file $FILENAME --header "Expect:"
}

checkTransaction() {
	if [ -z "$1" ]; then echo "please specify an address"; return 0;
	fi
	IP=$1
	SESSION_ID=`cat .session | grep session_id | cut -f7`
	curl https://$IP/api/transaction --request GET -k --cookie session_id=$SESSION_ID | jq ".body.status"
}

sps_rest() {
    local usage="Usage: $0 {auth|config|management} sps.ip.address"
    if  test -z "$1"; then
        echo "No SPS address supplied"
        echo $usage
        return 1
    fi
    local sps_address="$1"
    case "$2" in
        auth)
            sps_auth $sps_address
            ;;
        config)
            sps_config $sps_address
            ;;
        management)
            sps_management $sps_address
            ;;
        custom)
            [ test -z "$3"] && { echo "No end point is provided"; return 1 }
            local end_point="$3"
            sps_request $sps_address $end_point
            ;;
        *)
            echo $usage
            return 1
            ;;
    esac
}

sps_management() {
    sps_request "$1" "configuration/management"
}

sps_config() {
    sps_request "$1" "configuration"
}

sps_auth() {
    sps_request "$1" "authentication"
}

sps_request() {
    local sps_address="$1"
    local sps_api_url="https://$sps_address/api"
    local end_point="$sps_api_url/$2"
    http --verify=no --session=sps_admin --auth admin:a $end_point
}
