# Virtualbox releated functions and aliases

VBOX_COMMAND=VBoxManage

vm_start() {
    local vm="$1"
    local vm_state=$(vm_running $vm)
    if [ "$vm_state" -eq "0" ]; then
        $VBOX_COMMAND startvm $vm --type headless
    else
        echo "$vm is already running"
    fi
}

vm_stop() {
    local vm="$1"
    $VBOX_COMMAND controlvm $vm poweroff
}

vm_details() {
    local vm="$1"
    $VBOX_COMMAND showvminfo $vm --details
}

vm_snapshot() {
    local vm="$1"
    $VBOX_COMMAND snapshot $vm take
}

vm_show() {
    $VBOX_COMMAND list vms
}


vm_running() {
    local vm="$1"
    local state=0
    running_vms=(`VBoxManage list runningvms | awk '{print $1}'`)

    for v in $running_vms; do
        if [ "\"$vm\"" = "$v" ]; then
            state=1
            break
        fi
    done
    echo $state
}
