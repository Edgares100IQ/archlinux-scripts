#!/bin/bash

sudo -v
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-nopasswd-temp
sudo chmod 440 /etc/sudoers.d/99-nopasswd-temp
while true; do sudo -n true; sleep 50; done 2>/dev/null &
SUDO_PID=$!
trap 'sudo rm -f /etc/sudoers.d/99-nopasswd-temp; kill $SUDO_PID 2>/dev/null' EXIT

echo ">>> Instalando Steam..."
sudo pacman -S --needed flatpak --noconfirm
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.valvesoftware.Steam -y

echo ">>> Steam instalado"
