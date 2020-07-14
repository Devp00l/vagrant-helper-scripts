# YAVSR
Yet another vagrant script repository.

## libvirt-snapshot
With this script you can easily create snapshots of your libvirt vagrant machines.

Usage: `libvirt-snapshot <command>`

Make sure that your current working directory has a '.vagrant' directory

Available commands:

* `create` -> Creates snapshots from current machines
* `list` -> Lists created snapshots
* `remove` -> Removes created snapshots
* `revert` -> Reverts machines back to last snapshot state


## vagrant-common-action
Provides actions that are pretty common.
It also assumes that `libvirt-snapshot` is available as command too.

Usage: `vagrant-common-actions <command>`

Available commands:
* `rebuild` -> Rebuilds vagrant images and starts them (this takes a long time)"
* `create` -> Creates snapshots of current machines"
* `revert` -> Reverts snapshots of machines"

## vagrant-resolve-issues
Provides some helpful functions to (hopefully) be able to resolve vagrant issues quickly.

Usage: `vagrant-resolve-issues <command> [search]`

Available commands:
* `net` -> Shows net-list
* `net search` -> Undefines every net name that matches the search term
* `info` -> Gives a lot of information that could help resolving problems



## How to install the scripts?

To use it globally symlink the scripts to `/usr/local/bin`.
You probably have to be root to run the upcoming commands (`sudo -s`).

```
ln -s $PWD/libvirt-snapshot /usr/local/bin/libvirt-snapshot
ln -s $PWD/vagrant-common-actions /usr/local/bin/vagrant-common-actions
ln -s $PWD/vagrant-resolve-issues /usr/local/bin/vagrant-resolve-issues
```
