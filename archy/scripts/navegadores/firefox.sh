#!/bin/bash

# sudo sin contraseña
sudo -v
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-nopasswd-temp
sudo chmod 440 /etc/sudoers.d/99-nopasswd-temp
while true; do sudo -n true; sleep 50; done 2>/dev/null &
SUDO_PID=$!
trap 'sudo rm -f /etc/sudoers.d/99-nopasswd-temp; kill $SUDO_PID 2>/dev/null' EXIT

echo ">>> Instalando Firefox..."
sudo pacman -S --needed firefox --noconfirm

echo ">>> Firefox instalado"
