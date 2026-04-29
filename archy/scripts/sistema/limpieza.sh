#!/bin/bash
echo ">>> Limpiando caché de pacman..."
sudo pacman -Sc --noconfirm
echo ">>> Limpiando caché de yay..."
yay -Sc --noconfirm
echo ">>> Eliminando paquetes huérfanos..."
huerfanos=$(pacman -Qdtq)
if [ -n "$huerfanos" ]; then
    sudo pacman -Rns $huerfanos --noconfirm
    echo ">>> Paquetes huérfanos eliminados"
else
    echo ">>> No hay paquetes huérfanos"
fi
echo ">>> Limpieza completada"
