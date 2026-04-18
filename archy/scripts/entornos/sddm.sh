#!/bin/bash

sudo -v
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-nopasswd-temp
sudo chmod 440 /etc/sudoers.d/99-nopasswd-temp
while true; do sudo -n true; sleep 50; done 2>/dev/null &
SUDO_PID=$!
trap 'sudo rm -f /etc/sudoers.d/99-nopasswd-temp; kill $SUDO_PID 2>/dev/null' EXIT

echo ">>> Instalando tema SilentSDDM..."
cd /tmp
rm -rf SilentSDDM
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM
cd SilentSDDM
chmod +x install.sh
sudo ./install.sh

echo ">>> SilentSDDM instalado"
