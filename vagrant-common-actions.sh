#!/bin/bash
# $1 = recreate | save | revert

snapshot_script="$(dirname $0)/libvirt-snapshot.sh"

rebuild_machines(){
  echo "This can take a while..."
  echo "Halting all machines"
  vagrant halt
  echo "Destroying all machines"
  sudo vagrant destroy -f
  echo "Recreating all machines"
  vagrant up
  vagrant ssh-config > ssh-config
}

create_snapshots(){
  echo "Deleting old snapshots form current machines"
  $snapshot_script remove
  echo "Creating new snapshots form current machines"
  $snapshot_script create
}

revert_snapshots(){
  echo "Halting all machines"
  vagrant halt
  echo "Reverting machines to last snapshot"
  $snapshot_script revert
  echo "Starting machines"
  vagrant up
}

CMD=$1
case "${CMD}" in
rebuild)
    rebuild_machines
    ;;
create)
    create_snapshots
    ;;
revert)
    revert_snapshots
    ;;
*)
    echo "Usage: ./vagrant-common-actions.sh <command>"
    echo -e "\nAvailable commands:"
    echo -e "  rebuild \t Rebuilds vagrant images and starts them (this takes a long time)"
    echo -e "  create \t Creates snapshots of current machines"
    echo -e "  revert \t Reverts snapshots of machines"
    exit 1
esac

