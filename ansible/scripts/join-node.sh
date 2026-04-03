#!/usr/bin/env bash
set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: $0 '<commande k3s join>'"
  exit 1
fi

JOIN_CMD=$1

echo "[INFO] Installation K3S..."
sudo apt update && sudo apt install --fix-missing

#sudo snap install microk8s --classic --channel=1.30/stable

echo "[INFO] Ajout utilisateur au groupe k3s..."
sudo usermod -aG k3s $USER

echo "[INFO] Attente readiness..."
#sudo microk8s status --wait-ready
sudo k3s kubectl wait --for=condition=Ready node --all --timeout=120s

echo "[INFO] Join cluster..."
sudo $JOIN_CMD

echo "[INFO] Noeud ajouté au cluster."
