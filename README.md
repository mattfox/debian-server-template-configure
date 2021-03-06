# virtualbox-template-configure

Configure a guest after having been cloned from debian-server-template or ubuntu-server-template in Matt's VirtualBox install.

## Usage

* Clone debian-server-template or ubuntu-server-template. Ensure you reinitialize MAC addresses.
* Start the new guest. Log in as root (Debian) or mattfox (Ubuntu).
* Select a free IP address from the range 192.168.56.{50..254}
* Run these commands:

      sudo -i  # On Ubuntu only
      export NEW_IP=192.168.56.x
      export NEW_HOSTNAME=new-hostname
      export HOST_ONLY_IFACE=eth1  # Or something such as enp0s8
      /usr/local/bin/virtualbox-template-configure.sh
      reboot

* Add a stanza for this host to your `.ssh/config`.
* SSH to the host with the user `mattfox`.

## Template setup

Rough steps for setting up template:

* Configure new guest. Ensure iface 0 is NAT, iface 1 is host-only.
* Install OS.
* From console, log in as initial user. Manually launch DHCP client for host-only interface.
* Log in via SSH.
* Set authorized_key of initial user and of root, if available.
* Set .gitconfig of initial user:

      git config --global user.email "you@example.com"
      git config --global user.name "Your Name"

* If using /etc/network/interfaces:
  * Add /etc/network/interfaces.d/hostonly from this repo.
  * Ensure there's a `source /etc/network/interfaces.d/*` directive somewhere in `/etc/network/interfaces`.
* If using /etc/netplan:
  * Add /etc/netplan/10-enp0s8.yaml from this repo.
* Copy /usr/local/bin/virtualbox-template-configure.sh from this repo to /usr/local/bin/.
* Install VirtualBox Guest Additions:

  Install `virtualbox-guest-utils` package. Or,

      sudo -i
      apt-get install build-essential linux-headers-$(uname -r)
      mkdir -p /media/cdrom
      mount /dev/cdrom /media/cdrom/
      /media/cdrom/VBoxLinuxAdditions.run
      reboot
    
    After reboot:
    
      usermod --append --groups vboxsf ${initial-user}
