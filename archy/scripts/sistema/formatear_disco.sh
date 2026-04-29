#!/bin/bash
echo ">>> Discos disponibles:"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
echo ""
read -p "Introduce el disco a formatear (ej: /dev/sdb): " disco
read -p "Sistema de archivos (ext4, btrfs, ntfs, fat32): " fs
echo ""
echo "⚠️  ADVERTENCIA: esto borrará todos los datos de $disco"
read -p "¿Estás seguro? [s/N]: " confirm
if [[ "$confirm" =~ ^[sS]$ ]]; then
    case "$fs" in
        ext4)  sudo mkfs.ext4 "$disco" ;;
        btrfs) sudo mkfs.btrfs "$disco" ;;
        ntfs)  sudo pacman -S --needed ntfs-3g --noconfirm && sudo mkfs.ntfs "$disco" ;;
        fat32) sudo mkfs.vfat -F 32 "$disco" ;;
        *) echo "Sistema de archivos no soportado" ;;
    esac
    echo ">>> Disco formateado"
else
    echo "Operación cancelada"
fi
