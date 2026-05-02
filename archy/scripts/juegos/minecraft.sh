#!/bin/bash

echo ">>> Instalando dependencias (Java)..."
sudo pacman -S --needed jre-openjdk --noconfirm

echo ">>> Instalando Minecraft oficial..."
yay -S --noconfirm --needed --answerclean All --answerdiff None minecraft-launcher

echo ">>> Minecraft oficial instalado"
