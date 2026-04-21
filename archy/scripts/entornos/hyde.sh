#!/bin/bash


echo ">>> Instalando HyDE..."
sudo pacman -S --needed git base-devel --noconfirm
rm -rf ~/HyDE
git clone --depth 1 https://github.com/HyDE-Project/HyDE ~/HyDE
cd ~/HyDE/Scripts
chmod +x install.sh
./install.sh

echo ">>> HyDE instalado"