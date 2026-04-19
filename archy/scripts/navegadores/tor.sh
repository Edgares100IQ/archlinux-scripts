#!/bin/bash

sudo -v
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-nopasswd-temp
sudo chmod 440 /etc/sudoers.d/99-nopasswd-temp
while true; do sudo -n true; sleep 50; done 2>/dev/null &
SUDO_PID=$!
trap 'sudo rm -f /etc/sudoers.d/99-nopasswd-temp; kill $SUDO_PID 2>/dev/null' EXIT

echo ">>> Instalando Tor Browser..."
gpg --keyserver hkps://keys.openpgp.org --recv-keys EF6E286DDA85EA2A4BA7DE684E2C6E8793298290
yay -S --noconfirm --needed --answerclean All --answerdiff None tor-browser

echo ">>> Tor Browser instalado"
