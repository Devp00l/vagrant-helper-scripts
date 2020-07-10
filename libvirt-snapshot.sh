#!/bin/bash -e

set_base_variables() {
    if [ ! -e .vagrant ]; then
        echo "No .vagrant folder found"
        exit 1
    fi

    # required for non-root user
    export LIBVIRT_DEFAULT_URI=qemu:///system

    echo "Get current vagrant machines"
    prefix=$(basename $(pwd))
    MACHINES=$(vagrant status | grep libvirt | awk '{print $1}'| sed "s/^/${prefix}_")
    echo -e "Found:\n$MACHINES"
}

create_snapshots() {
    set_base_variables
    for MACHINE in ${MACHINES}; do
        if virsh snapshot-current $MACHINE &> /dev/null ; then
            echo "${MACHINE} already has a current snapshot."
        else
            virsh snapshot-create $MACHINE
        fi
    done
}

revert_snapshots() {
    set_base_variables
    for MACHINE in ${MACHINES}; do
        if virsh snapshot-current $MACHINE &> /dev/null ; then
            set +o errexit
            virsh destroy ${MACHINE} 2> /dev/null
            set -o errexit
            echo "Revert ${MACHINE} to current"
            virsh snapshot-revert ${MACHINE} --current
        else
            echo "${MACHINE} has no current snapshot."
        fi
    done
}

remove_snapshots() {
    set_base_variables
    for MACHINE in ${MACHINES}; do
        set +o errexit
        CURRENT=$(virsh snapshot-current $MACHINE 2>/dev/null)
        if [ $? -eq 0 ]; then
            virsh snapshot-delete ${MACHINE} --current
        else
            echo "${MACHINE} has no current snapshot."
        fi
        set -o errexit
    done
}

list_snapshots() {
    set_base_variables
    for MACHINE in ${MACHINES}; do
        set +o errexit
        virsh snapshot-list ${MACHINE}
        set -o errexit
    done
}

CMD=$1
if [ x"${CMD}" = "x" ]; then
    CMD="list"
fi
case "${CMD}" in
create)
    create_snapshots
    ;;
remove)
    remove_snapshots
    ;;
list)
    list_snapshots
    ;;
revert)
    revert_snapshots
    ;;
*)
    echo "Usage: ./libvirt-snapshot.sh <command>"
    echo "Make sure that your current working directory has a '.vagrant' directory."
    echo -e "\nAvailable commands:"
    echo -e "    create \t\t Create snapshots from current machines"
    echo -e "    list \t\t Lists created snapshots"
    echo -e "    remove \t\t Removes created snapshots"
    echo -e "    revert \t\t Reverts machines back to last snapshot state"
    exit 1
esac

