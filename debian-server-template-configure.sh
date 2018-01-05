#!/bin/bash
if [ "${NEW_IP}" == "" ]; then
  echo "Error: new IP address not provided. Try:"
  echo "export NEW_IP=192.168.56.x"
  exit 1
fi
if [ "${NEW_HOSTNAME}" == "" ]; then
  echo "Error: new hostname not provided. Try:"
  echo "export NEW_HOSTNAME=new-hostname"
  exit 1
fi
if [ "${HOST_ONLY_IFACE}" == "" ]; then
  echo "Error: host only interface name not provided. Try:"
  echo "export HOST_ONLY_IFACE=eth1"
  exit 1
fi

# Set IP address on host-only adapter
# In Ubuntu Server, install package ifupdown2 to get interfaces.d.
HOST_ONLY_IFACE_FILE="/etc/network/interfaces.d/hostonly"
sed --in-place "s/HOST_ONLY_ADDR/${NEW_IP}/" ${HOST_ONLY_IFACE_FILE}
sed --in-place "s/#//" ${HOST_ONLY_IFACE_FILE} # Remove comments

# Set hostname
ORIGINAL_HOSTNAME=$(cat /etc/hostname)
echo ${NEW_HOSTNAME} > /etc/hostname
sed --in-place "s/${ORIGINAL_HOSTNAME}/${NEW_HOSTNAME}/" /etc/hosts

# Regenerate SSH host keys
rm --force --verbose /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server
