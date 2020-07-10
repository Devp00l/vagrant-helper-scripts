# YAVSR
Yet another vagrant script repository.

## libvirt-snapshot.sh
With this script you can easily create snapshots of your libvirt vagrant machines.

Usage: `./libvirt-snapshot.sh <command>`

Make sure that your current working directory has a '.vagrant' directory

Available commands:

* `create` -> Creates snapshots from current machines
* `list` -> Lists created snapshots
* `remove` -> Removes created snapsshots
* `revert` -> Reverts machines back to last snapshot state


## vagrant-common-action.sh
Provides actions that are pretty common.
It also assumes that `libvirt-snapshot.sh` exists in the same directory.

Usage: `./vagrant-common-actions.sh <command>`

Available commands:
* `rebuild` -> Rebuilds vagrant images and starts them (this takes a long time)"
* `create` -> Creates snapshots of current machines"
* `revert` -> Reverts snapshots of machines"


## How to isntall the scripts?

One way would be to use the path of you clone inside your `$PATH` in your shell configuration or profile.

```
export PATH=$PATH:$ClonePath
```

To use it globally copy or symlink the scripts to `/usr/local/bin`.
You propably have to be root to run the upcoming commands (`sudo -s`).

To copy them:

```
cp *.sh /usr/local/bin
```

To symlink them:

```
ln -s $PWD/libvirt-snapshot.sh /usr/local/bin/libvirt-snapshot.sh
ln -s $PWD/vagrant-common-actions.sh /usr/local/bin/vagrant-common-actions.sh
```