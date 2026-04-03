#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Mise à jour système..."
sudo apt update && sudo apt upgrade -y

sudo curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.33.3%2Bk3s1/k3s
sudo chmod +x /usr/local/bin/k3s
curl -Lo install.sh https://get.k3s.io
chmod +x install.sh

echo "[INFO] Installation K3S..."
#sudo snap install microk8s --classic --channel=1.30/stable
INSTALL_K3S_SKIP_DOWNLOAD=true ./install.sh

echo "[INFO] Ajout utilisateur au groupe k3s..."
#sudo usermod -aG k3s $USER
#sudo chown -f -R $USER ~/.kube

echo "[INFO] Attente du cluster..."
#sudo microk8s status --wait-ready

echo "[INFO] Activation des addons de base..."
#sudo microk8s enable dns ingress metrics-server

echo "[INFO] Alias kubectl..."
#sudo snap alias microk8s.kubectl kubectl

echo "[INFO] Génération token pour joindre d'autres noeuds..."
#JOIN_CMD=$(sudo microk8s add-node | grep "microk8s join")
export YOUR_TOKEN=sudo cat /var/lib/rancher/k3s/server/node-token
INSTALL_K3S_SKIP_DOWNLOAD=true K3S_URL=https://<SERVER_IP>:6443 K3S_TOKEN=<YOUR_TOKEN> ./install.shecho ""
echo "=============================="
echo "Commande pour ajouter un noeud :"
echo "$JOIN_CMD"
echo "=============================="
