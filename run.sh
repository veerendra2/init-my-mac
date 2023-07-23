#!/usr/bin/env bash

CUR_USER=`whoami`
echo "[*] Add $CUR_USER to sudoer"
echo "${CUR_USER} ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/custom

if [ "$(uname -m)" == "arm64" ]; then
  # apple silicon
  export PATH=/opt/homebrew/bin:$PATH
else
  # intel
  export PATH=/usr/local/bin:$PATH
fi

echo "[*] Set default shell -> $(brew --prefix)/bin/bash"
bash -c 'echo $(brew --prefix)/bin/bash | sudo tee -a /etc/shells'
chsh -s $(brew --prefix)/bin/bash

echo "[*] Change ownership -> $(brew --prefix)/*"
chown -R ${CUR_USER} $(brew --prefix)/*

echo "[*] Install python3"
brew install python3
python3 -m pip install --upgrade pip

echo "[*] Install ansible"
pip3 install ansible

if [[ $(git remote get-url origin) != "https://github.com/veerendra2/init-my-mac" ]]; then
  mkdir -p ~/projects > /dev/null
  pushd ~/projects
  ssh-keyscan github.com >> ~/.ssh/known_hosts
  git clone git@github.com:veerendra2/init-my-mac.git
  pushd init-my-mac > /dev/null
fi

echo "***************** Starting Ansible Playbook *****************"
ansible-playbook main.yml
