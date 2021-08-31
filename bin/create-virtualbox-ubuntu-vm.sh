#!/bin/bash
set -x
set -e

MACHINENAME=$1
HD_MB=20480
ISO_PATH="${HOME}/Downloads/ubuntu_vm.iso"

if [ -z "$MACHINENAME" ]; then
  echo "need a machine name on the command line, failing..." >&2
  exit 1
fi

# Download ubuntu_vm.iso
if [ ! -f "${ISO_PATH}" ]; then
  wget https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso -O "${ISO_PATH}"
fi

#Create VM
VBoxManage createvm --name $MACHINENAME --ostype "Ubuntu_64" --register --basefolder "$(pwd)"
#Set memory and network
VBoxManage modifyvm $MACHINENAME --ioapic on
VBoxManage modifyvm $MACHINENAME --memory 2048 --vram 128
#VBoxManage modifyvm $MACHINENAME --nic1 nat
VBoxManage modifyvm $MACHINENAME --nic1 bridged --bridgeadapter1 enp0s25
#Create Disk and connect Debian Iso
VBoxManage createhd --filename "$(pwd)"/$MACHINENAME/$MACHINENAME_DISK.vdi --size $HD_MB --format VDI
VBoxManage storagectl $MACHINENAME --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  "$(pwd)"/$MACHINENAME/$MACHINENAME_DISK.vdi
VBoxManage storagectl $MACHINENAME --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach $MACHINENAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "${ISO_PATH}"
VBoxManage modifyvm $MACHINENAME --boot1 dvd --boot2 disk --boot3 none --boot4 none

#Enable RDP
# you can connect to this host:10001 with RDP to run through the installer UI
VBoxManage modifyvm $MACHINENAME --vrde on
VBoxManage modifyvm $MACHINENAME --vrdemulticon on --vrdeport 10001

#Start the VM
VBoxHeadless --startvm $MACHINENAME
