#!/bin/bash
echo ">>> Herramienta DD"
echo "1. clonar disco a disco"
echo "2. crear imagen de disco"
echo "3. restaurar imagen a disco"
read -p "Elige una opcion: " op
case "$op" in
    1)
        lsblk -o NAME,SIZE,TYPE
        read -p "Disco origen (ej: /dev/sda): " origen
        read -p "Disco destino (ej: /dev/sdb): " destino
        echo "⚠️  ADVERTENCIA: esto sobreescribirá $destino"
        read -p "¿Estás seguro? [s/N]: " confirm
        [[ "$confirm" =~ ^[sS]$ ]] && sudo dd if="$origen" of="$destino" bs=4M status=progress
        ;;
    2)
        lsblk -o NAME,SIZE,TYPE
        read -p "Disco a clonar (ej: /dev/sda): " disco
        read -p "Ruta de la imagen (ej: /home/user/backup.img): " imagen
        sudo dd if="$disco" of="$imagen" bs=4M status=progress
        ;;
    3)
        read -p "Ruta de la imagen: " imagen
        lsblk -o NAME,SIZE,TYPE
        read -p "Disco destino (ej: /dev/sda): " destino
        echo "⚠️  ADVERTENCIA: esto sobreescribirá $destino"
        read -p "¿Estás seguro? [s/N]: " confirm
        [[ "$confirm" =~ ^[sS]$ ]] && sudo dd if="$imagen" of="$destino" bs=4M status=progress
        ;;
esac
