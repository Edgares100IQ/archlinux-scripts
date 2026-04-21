#!/bin/bash


echo ">>> Instalando Tor Browser..."
gpg --keyserver hkps://keys.openpgp.org --recv-keys EF6E286DDA85EA2A4BA7DE684E2C6E8793298290
yay -S --noconfirm --needed --answerclean All --answerdiff None tor-browser-bin

echo ">>> Tor Browser instalado"