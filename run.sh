#!/bin/bash

CUR_USER=`whoami`
echo "[*] Add $CUR_USER to sudoer"
echo "$CUR_USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/custom

# echo "[*] Install homebrew"
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "[*] Install pip3"
brew install pip3

echo "[*] Install ansible"
pip3 install ansible

mkdir -p ~/projects
pushd ~/projects
git clone git@github.com:veerendra2/init-my-mac.git
pushd init-my-mac

echo "***************** Starting Ansible Playbook *****************"
exec ansible-playbook main.yml
