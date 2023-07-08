#!/bin/bash

# Get the starting VM number from the user
echo "Please enter the starting number for the VMs:"
read start_number

# Get the number of VMs to create
echo "Please enter the number of VMs to create:"
read num_vms

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

# Loop to create the VM clones
for ((i = 1; i <= num_vms; i++)); do
  vm_id=$(($start_number + $i))
  vm_name="vm$vm_id"
  echo "Creating VM $vm_id: $vm_name"
  qm clone $template_id $vm_id --name $vm_name

  # Start the VM
  qm start $vm_id
  sleep 50  # Attente de 10 secondes pour permettre au système de démarrer
  # Execute predefined commands inside the VM
  echo "Installing packages and performing updates inside VM $vm_id"
  qm guest exec $vm_id -- sudo apt update
  qm guest exec $vm_id -- sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.bak
  
done

echo "VM clones created successfully."
