#!/bin/bash

# Echo commands to guide the user
echo "Installing Ubuntu"
sleep 3
echo "by Allegorie Group"
sleep 1
echo "Downloading Ubuntu Image"
wget https://cloud-images.ubuntu.com/minimal/releases/focal/release/ubuntu-20.04-minimal-cloudimg-amd64.img


# Ask for the VM ID
echo "Please enter the virtual machine ID:"
read vm_id

# Create a new VM with the specified ID and RAM
qm create $vm_id --name ubuntu-2004-template --onboot 1 --agent 1 --memory 1024

# Rename and resize the image
mv ubuntu-20.04-minimal-cloudimg-amd64.img ubuntu-20.04.qcow2
qemu-img resize ubuntu-20.04.qcow2 32G

# Import the disk to the VM
qm importdisk $vm_id ubuntu-20.04.qcow2 local-lvm

# Attach the imported disk to the VM
qm set $vm_id --scsi0 local-lvm:vm-$vm_id-disk-0

# Enable SSD emulation and discard for the disk
qm set $vm_id --scsi0 local-lvm:vm-$vm_id-disk-0,discard=on,ssd=1

# Add a CloudInit drive to the VM with the default settings
qm set $vm_id --ide2 local-lvm:cloudinit

# Set the VM to use the CloudInit drive for user management and set the user credentials
qm set $vm_id --cipassword allegorie --ciuser allegorie

# Ask for the public SSH key
echo "Please paste your public SSH key:"
read ssh_key

# Write the SSH key to a temporary file
echo $ssh_key > temp.pub

# Set the SSH key
qm set $vm_id --sshkeys temp.pub

# Remove the temporary file
rm temp.pub

# Set network configuration
qm set $vm_id --net0 virtio,bridge=vmbr0

qm set $vm_id --ipconfig0 ip=dhcp


# Edit VM's hardware settings
qm set $vm_id --scsihw virtio-scsi-pci

# Set bootdisk
qm set $vm_id --bootdisk scsi0

# Set all boot order enabled
qm set $vm_id --boot c

# Set bootdisk
qm set $vm_id --bootdisk scsi0

# Set all boot order enabled
qm set $vm_id --boot ndc

# Set serial device
qm set $vm_id --serial0 socket

# Set VGA option for the serial device
qm set $vm_id --vga serial0

# Set SCSI Controller to VirtIO SCSI single
qm set $vm_id --scsihw virtio-scsi-single


echo " sudo apt install qemu-guest-agent && sudo systemctl enable qemu-guest-agent && sudo shutdown"
