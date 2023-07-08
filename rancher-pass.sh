# Exécute la commande 'docker ps' pour afficher les conteneurs en cours
container_info=$(sudo docker ps)

# Récupère l'ID du premier conteneur de la liste
container_id=$(echo "$container_info" | awk 'NR==2 {print $1}')

# Exécute la commande 'docker logs' pour récupérer les logs du conteneur
container_logs=$(docker logs "$container_id" 2>&1)

# Affiche le mot de passe
sudo docker logs  $container_id  2>&1 | grep "Bootstrap Password:"
