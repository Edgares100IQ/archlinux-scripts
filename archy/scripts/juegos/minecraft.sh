#!/bin/bash

echo ">>> Instalando dependencias (Java)..."
sudo pacman -S --needed jre-openjdk --noconfirm

echo ""
echo "¿Qué versión quieres instalar?"
echo "1. Minecraft oficial (Microsoft)"
echo "2. TLauncher"
read -p "> " op

case "$op" in
    1)
        echo ">>> Instalando Minecraft oficial..."
        yay -S --noconfirm --needed --answerclean All --answerdiff None minecraft-launcher
        echo ">>> Minecraft oficial instalado"
        ;;
    2)
        echo ">>> Instalando TLauncher..."
        yay -S --noconfirm --needed --answerclean All --answerdiff None tlauncher
        echo ">>> TLauncher instalado"
        ;;
    *)
        echo "opción no válida"
        ;;
esac
