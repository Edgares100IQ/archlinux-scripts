#!/bin/bash
echo ">>> Actualizando mirrors..."
sudo pacman -S --noconfirm --needed reflector
sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy
echo ">>> Instalando Telegram..."
sudo pacman -S --noconfirm --needed telegram-desktop
echo ">>> Telegram instalado"
