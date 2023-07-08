#!/bin/bash

# Get the number of VMs to create
echo "Veuillez entrer le nombre de VMs à créer :"
read num_vms

# Get the template ID to clone
echo "Veuillez sélectionner le modèle à cloner :"

# List all available VMs
qm list

# Get the template ID from the user
read template_id

# Check if the template exists
if ! qm list | awk '{print $1}' | grep -q "^$template_id$"; then
  echo "ID de modèle invalide. Sortie."
  exit 1
fi

# Loop to create the VM clones
for ((i = 1; i <= num_vms; i++)); do

  # Get the VM name from the user
  echo "Veuillez entrer le nom pour la VM $i :"
  read vm_name

  # Get the RAM size from the user in GB and convert it to MB
  echo "Veuillez entrer la quantité de RAM en GB pour la VM $i :"
  read ram_gb
  ram_mb=$(($ram_gb*1024))

  # Get the number of CPU cores from the user
  echo "Veuillez entrer le nombre de cœurs CPU pour la VM $i :"
  read cpu_cores

  # List all available storage
  echo "Voici tous les stockages disponibles :"

  # Here you should implement a command that lists all storages. 
  # I'm going to use a placeholder as I don't know how your environment is set up.
  pvesm status

  # Get the storage ID from the user
  echo "Veuillez sélectionner le stockage pour la VM $i :"
  read storage_id

  vm_id=$(($template_id + $i))
  echo "Création de la VM $vm_id: $vm_name"
  qm clone $template_id $vm_id --name $vm_name

  # Update the VM parameters
  qm set $vm_id --memory $ram_mb
  qm set $vm_id --cores $cpu_cores

  # Here, replace `storage_option` with the appropriate storage option according to your setup
  qm set $vm_id --storage_option $storage_id 

  # Start the VM
  qm start $vm_id
  
done

echo "Clones de VM créés avec succès."
