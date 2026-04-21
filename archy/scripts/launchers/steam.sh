#!/bin/bash


echo ">>> Instalando Steam..."
sudo pacman -S --needed flatpak --noconfirm
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.valvesoftware.Steam -y

echo ">>> Steam instalado"