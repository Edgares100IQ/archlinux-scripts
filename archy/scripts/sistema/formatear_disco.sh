#!/bin/bash

# obtener lista de discos con nombre legible
mapfile -t discos < <(lsblk -o NAME,SIZE,MODEL,TYPE --noheadings | grep "disk" | awk '{printf "%s — %s — %s\n", $1, $2, $3}')
count=${#discos[@]}

if [ "$count" -eq 0 ]; then
    echo "No se encontraron discos"
    read -p "pulsa enter para continuar..."
    exit 1
fi

# menu de seleccion de disco
selected=0
printf '\e[?25l'

draw_discos() {
    clear
    echo "=== Selecciona el disco a formatear ==="
    echo ""
    for i in "${!discos[@]}"; do
        if [ "$i" -eq "$selected" ]; then
            echo -e "\e[7m  ${discos[$i]}  \e[0m"
        else
            echo "  ${discos[$i]}"
        fi
    done
    echo "  ↩  cancelar"
}

draw_discos

while true; do
    IFS= read -rsn1 key
    if [[ "$key" == $'\x1b' ]]; then
        read -rsn2 -t 0.1 key
        case "$key" in
            '[A') ((selected--)); [ "$selected" -lt 0 ] && selected=$count; draw_discos ;;
            '[B') ((selected++)); [ "$selected" -gt "$count" ] && selected=0; draw_discos ;;
        esac
    elif [[ "$key" == "" ]]; then
        break
    fi
done

printf '\e[?25h'

# cancelar si eligio la ultima opcion
if [ "$selected" -eq "$count" ]; then
    echo "Operación cancelada"
    exit 0
fi

# obtener nombre del disco seleccionado
disco_nombre=$(echo "${discos[$selected]}" | awk '{print $1}')
disco="/dev/$disco_nombre"

# menu de sistema de archivos
fs_opts=("ext4" "btrfs" "ntfs" "fat32" "↩  cancelar")
fs_selected=0

draw_fs() {
    clear
    echo "=== Sistema de archivos para $disco ==="
    echo ""
    for i in "${!fs_opts[@]}"; do
        if [ "$i" -eq "$fs_selected" ]; then
            echo -e "\e[7m  ${fs_opts[$i]}  \e[0m"
        else
            echo "  ${fs_opts[$i]}"
        fi
    done
}

printf '\e[?25l'
draw_fs

while true; do
    IFS= read -rsn1 key
    if [[ "$key" == $'\x1b' ]]; then
        read -rsn2 -t 0.1 key
        case "$key" in
            '[A') ((fs_selected--)); [ "$fs_selected" -lt 0 ] && fs_selected=$((${#fs_opts[@]}-1)); draw_fs ;;
            '[B') ((fs_selected++)); [ "$fs_selected" -ge "${#fs_opts[@]}" ] && fs_selected=0; draw_fs ;;
        esac
    elif [[ "$key" == "" ]]; then
        break
    fi
done

printf '\e[?25h'

if [ "$fs_selected" -eq $((${#fs_opts[@]}-1)) ]; then
    echo "Operación cancelada"
    exit 0
fi

fs="${fs_opts[$fs_selected]}"

# confirmacion
clear
echo "⚠️  ADVERTENCIA"
echo ""
echo "  Disco:  $disco (${discos[$selected]})"
echo "  Formato: $fs"
echo ""
echo "  Todos los datos se perderán de forma permanente."
echo ""
read -p "¿Estás seguro? escribe 'SI' para confirmar: " confirm

if [ "$confirm" == "SI" ]; then
    echo ""
    echo ">>> Formateando $disco como $fs..."
    case "$fs" in
        ext4)  sudo mkfs.ext4 "$disco" ;;
        btrfs) sudo mkfs.btrfs -f "$disco" ;;
        ntfs)  sudo pacman -S --needed ntfs-3g --noconfirm && sudo mkfs.ntfs -f "$disco" ;;
        fat32) sudo mkfs.vfat -F 32 "$disco" ;;
    esac
    echo ">>> Disco formateado correctamente"
else
    echo "Operación cancelada"
fi

read -p "pulsa enter para continuar..."
