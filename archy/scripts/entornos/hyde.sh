#!/bin/bash

sudo -v
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-nopasswd-temp
sudo chmod 440 /etc/sudoers.d/99-nopasswd-temp
while true; do sudo -n true; sleep 50; done 2>/dev/null &
SUDO_PID=$!
trap 'sudo rm -f /etc/sudoers.d/99-nopasswd-temp; kill $SUDO_PID 2>/dev/null' EXIT

echo ">>> Instalando HyDE..."
sudo pacman -S --needed git base-devel --noconfirm
rm -rf ~/HyDE
git clone --depth 1 https://github.com/HyDE-Project/HyDE ~/HyDE
cd ~/HyDE/Scripts
chmod +x install.sh
./install.sh

echo ">>> HyDE instalado"