# Set Up all required tools for the project on a ubuntu system
# This script is intended to be run as root or with sudo privileges
# It installs the following tools:

#!/bin/bash
set -e

echo "[*] Updating system and installing base packages..."
sudo apt update && sudo apt install -y \
  curl git unzip tar gnupg lsb-release software-properties-common apt-transport-https ca-certificates

### Install kubectl ###
echo "[*] Installing kubectl..."
curl -fsSL "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

### Install Helm ###
echo "[*] Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

### Install Kustomize ###
echo "[*] Installing Kustomize..."
KUSTOMIZE_VERSION=$(curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -L -o kustomize.tar.gz "https://github.com/kubernetes-sigs/kustomize/releases/download/${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION#kustomize/}_linux_amd64.tar.gz"
tar -zxvf kustomize.tar.gz
chmod +x kustomize
sudo mv kustomize /usr/local/bin/
rm kustomize.tar.gz

### Install Krew ###
echo "[*] Installing Krew..."
(
  set -x
  cd "$(mktemp -d)"
  OS="linux"
  ARCH="$(uname -m)"
  [[ "$ARCH" == "x86_64" ]] && ARCH="amd64"
  KREW="krew-${OS}_${ARCH}"
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
  tar zxvf "${KREW}.tar.gz"
  ./"${KREW}" install krew
)

# Add Krew to PATH and set aliases
echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> ~/.bashrc
echo 'alias krew="kubectl-krew"' >> ~/.bashrc
echo 'alias k="kubectl"' >> ~/.bashrc
echo 'alias tf="terraform"' >> ~/.bashrc
echo 'alias pkr="packer"' >> ~/.bashrc
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

### Install Terraform and Packer ###
echo "[*] Installing Terraform and Packer..."
HASHICORP_GPG_KEY_URL="https://apt.releases.hashicorp.com/gpg"
DISTRIB_CODENAME="$(lsb_release -cs)"

curl -fsSL "$HASHICORP_GPG_KEY_URL" | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com ${DISTRIB_CODENAME} main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install -y terraform packer

### Install LXC tools ###
echo "[*] Installing LXC and LXD..."
sudo apt update
sudo apt install lxc-utils lxc -y

source ~/.bashrc

echo "[*] Installation complete."
