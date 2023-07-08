#!/bin/bash
sudo apt install nano
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
sudo apt update && sudp apt upgrade
sudo curl https://releases.rancher.com/install-docker/20.10.sh | sh
sudo apt-get install -qq docker-ce=5:20.10.24~3-0~ubuntu-focal docker-ce-cli=5:20.10.24~3-0~ubuntu-focal containerd.io docker-compose-plugin docker-ce-rootless-extras=5:20.10.24~3-0~ubuntu-focal --allow-downgrades
sudo usermod -aG docker $USER
sudo docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher
sudo usermod -aG sudo $USER

# Exécute la commande 'docker ps' pour afficher les conteneurs en cours
container_info=$(docker ps)

# Récupère l'ID du premier conteneur de la liste
container_id=$(echo "$container_info" | awk 'NR==2 {print $1}')

# Exécute la commande 'docker logs' pour récupérer les logs du conteneur
container_logs=$(docker logs "$container_id" 2>&1)

# Recherche le mot de passe dans les logs à l'aide d'une expression régulière
password_regex='Bootstrap Password:\s*([^\n\r]*)'
if [[ $container_logs =~ $password_regex ]]; then
    password=${BASH_REMATCH[1]}
else
    echo "Impossible de trouver le mot de passe dans les logs du conteneur $container_id."
    exit 1
fi

# Affiche le mot de passe
echo "Mot de passe du conteneur $container_id : $password"
