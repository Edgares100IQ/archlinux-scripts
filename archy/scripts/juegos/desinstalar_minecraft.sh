#!/bin/bash

oficial=false
tlauncher=false

pacman -Q minecraft-launcher &>/dev/null && oficial=true
pacman -Q tlauncher &>/dev/null && tlauncher=true

if $oficial && $tlauncher; then
    echo "Tienes instalado minecraft-launcher (oficial) y tlauncher"
    echo "1. desinstalar minecraft oficial"
    echo "2. desinstalar tlauncher"
    echo "3. desinstalar ambos"
    read -p "Elige una opcion: " op
    case "$op" in
        1) yay -Rns minecraft-launcher --noconfirm ;;
        2) yay -Rns tlauncher --noconfirm ;;
        3) yay -Rns minecraft-launcher tlauncher --noconfirm ;;
        *) echo "opcion no valida" ;;
    esac
elif $oficial; then
    echo ">>> Desinstalando Minecraft oficial..."
    yay -Rns minecraft-launcher --noconfirm
    echo ">>> Minecraft desinstalado"
elif $tlauncher; then
    echo ">>> Desinstalando TLauncher..."
    yay -Rns tlauncher --noconfirm
    echo ">>> TLauncher desinstalado"
else
    echo "No se encontró ninguna versión de Minecraft instalada"
fi
