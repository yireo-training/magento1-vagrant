# Vagrant image for Magento 2
This repository contains all the files to get a VM up and running via Vagrant. Recommended is to assign at least 4Gb of RAM to this VM.

## Specifications
This Vagrant installs the following into a VM:
- Nginx
- PHP7
- Redis
- Magerun
- Magento 1
- Inchoo PHP7 module

## Configuration

### Vagrant configuration
The Vagrant configuration should be copied from `Vagrantfile.sample` to `Vagrantfile`.

    cp Vagrantfile.sample Vagrantfile

This Vagrant configuration uses NFS. Under Linux or MacOS this image should work out of the box, as long
as you have NFS installed. Under Windows, you might want to try WinNFSd or change the configuration in 
`Vagrantfile` to use an alternative to NFS. Alternatively (for any OS) you might want to opt for the `rsync` option -
just make sure to run the command `vagrant rsync-auto` on the host side.

Memory is assigned to the VM by modifying the `--memory` variable in `Vagrantfile`. Note that some
parameters like the `query_cache` in `mysqld.cnf` might also be tuned accordingly.

The folder `vagrant_files` includes a couple of files that are copied to the VM. Because the installer needs
to access to the Magento repositories, make sure to add a file `composer-auth.json` with your Magento
credentials in place. If you skip this step, the Magento install will fail. An example is located in
`composer-auth.json.sample`.

### Magento files
This repository does not include the Magento installation files. Add the following files to the folder `magento_files`:
- `magento-1.9.3.1.tar.gz`
- `magento-sample-data-1.9.1.0.tar.gz`

For instance, you can download these files via http://pubfiles.nexcess.net/magento/

Alternatively, copy the files of the version of your liking, and modify the configuration `vagrant_files/n98-magerun.yaml`.

## Usage
Bring up this Vagrant image:

    vagrant up

Once the machine is up and running, Vagrant will run all the steps in the script `vagrant-init.sh`. After
all steps are done, Magento 1 should be available under the following URL:

http://magento1.local/

Magento backend login is available under http://magento1.local/admin with username *admin* and password *admin1234*.

Because Magento 1 enforces a redirect to the right hostname, you will need to add a host-entry to your `hosts`
file. Under Linux, this is the file `/etc/hosts`:

    192.168.80.80   magento1.local

You can manage the VM by SSH-ing to it:

    vagrant ssh

The machine is in Developer Mode by default. Magento 1 is installed into the folder `source` of the
Vagrant folder, so that you can access all files via the hosting environment (your computer). The only exception is that the `var/`
is a symbolic link to the VMs `/tmp` folder so that the VM folder-synchronization (f.e. NFS) does not go crazy.

