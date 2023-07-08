#!/bin/bash

# Demande de l'adresse IP
read -p "Veuillez entrer l'adresse IP : " ip_address

# Demande de la passerelle
read -p "Veuillez entrer la passerelle : " gateway

# Création du fichier de configuration
cat > /tmp/netplan_config.yaml <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - $ip_address/24
      gateway4: $gateway
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
EOF

# Copie du fichier de configuration vers /etc/netplan/50-cloud-init.yaml
sudo cp /tmp/netplan_config.yaml /etc/netplan/50-cloud-init.yaml

# Application de la configuration
sudo netplan try
