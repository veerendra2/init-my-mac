#!/bin/bash

CUR_USER=`whoami`
echo "[*] Add $CUR_USER to sudoer"
echo "$CUR_USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$CUR_USER

echo "[*] Install homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "[*] Install pip3"
brew install pip3

echo "[*] Install ansible"
pip3 install ansible

mkdir -p ~/projects
git clone https://github.com/veerendra2/ubuntu-dev.git ~/projects/ubuntu-dev
pushd ~/projects/ubuntu-dev

echo "***************** Starting Ansible Playbook *****************"
exec ansible-playbook main.yml
