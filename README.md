# debian-server-template-configure

Configure a guest after having been cloned from debian-server-template in Matt's VirtualBox install.

## Usage

* Clone debian-server-template. Ensure you get new MAC addresses.
* Start the new guest. Log in as root.
* Select a free IP address from the range 192.168.56.{50..254}
* Run these commands:

```bash
export NEW_IP=192.168.56.x
export NEW_HOSTNAME=new-hostname
/usr/local/bin/debian-server-template-configure.sh
reboot
````

* Add a stanza for this host to your `.ssh/config`.
* SSH to the host with the user `mattfox`.
