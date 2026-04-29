#!/bin/bash
if ! command -v smartctl &>/dev/null; then
    sudo pacman -S --needed smartmontools --noconfirm
fi
echo ">>> Discos disponibles:"
lsblk -o NAME,SIZE,TYPE | grep disk
echo ""
read -p "Introduce el disco (ej: /dev/sda): " disco
echo ""
echo ">>> Salud del disco $disco:"
sudo smartctl -H "$disco"
echo ""
echo ">>> Información detallada:"
sudo smartctl -a "$disco" | grep -E "Temperature|Reallocated|Pending|Uncorrectable|Power_On|Start_Stop"
