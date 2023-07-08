# Exécute la commande 'docker ps' pour afficher les conteneurs en cours
container_info=$(sudo docker ps)

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
sudo echo "Mot de passe du conteneur $container_id : $password"
