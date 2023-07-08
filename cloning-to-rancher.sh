#!/bin/bash

# Get the starting VM number from the user
echo "Please enter the number for the VM:"
read vm_id

# Get the template ID to clone
echo "Please select the template to clone:"

# List all available VMs
qm list

# Get the template ID from the user
read template_id

# Check if the template exists
if ! qm list | awk '{print $1}' | grep -q "^$template_id$"; then
  echo "Invalid template ID. Exiting."
  exit 1
fi

vm_name="vm$vm_id"
echo "Creating VM $vm_id: $vm_name"

# Clone the VM and set memory and cpu cores
qm clone $template_id $vm_id --name $vm_name
qm set $vm_id --memory 4096 --sockets 1 --cores 2

# Start the VM
qm start $vm_id

echo "VM clone created successfully."
