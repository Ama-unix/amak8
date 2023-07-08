#!/bin/bash

# Obtenez l'adresse IPv4 actuelle de votre machine
IP=$(hostname -I | awk '{print $1}')

# Exécutez la commande kubeadm init avec votre adresse IP actuelle
sudo kubeadm init --control-plane-endpoint="$IP" --node-name k8s-ctrlr --pod-network-cidr=10.244.0.0/16 

# Créez le dossier .kube dans votre répertoire home si ce n'est pas déjà fait
mkdir -p $HOME/.kube

# Copiez le fichier admin.conf dans votre répertoire .kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

# Changez la propriété du fichier de configuration à l'utilisateur actuel
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Vérifiez les pods dans tous les namespaces
kubectl get pods --all-namespaces

# Appliquez le fichier de configuration flannel
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

# Vérifiez encore une fois les pods dans tous les namespaces
kubectl get pods --all-namespaces

# Regenrate the join token
kubeadm token create --print-join-command
