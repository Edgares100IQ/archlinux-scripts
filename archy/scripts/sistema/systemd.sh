#!/bin/bash
echo "1. ver servicios activos"
echo "2. ver servicios fallidos"
echo "3. activar un servicio"
echo "4. desactivar un servicio"
read -p "Elige una opcion: " op
case "$op" in
    1) systemctl list-units --type=service --state=running | less ;;
    2) systemctl --failed ;;
    3) read -p "Nombre del servicio: " svc; sudo systemctl enable --now "$svc" ;;
    4) read -p "Nombre del servicio: " svc; sudo systemctl disable --now "$svc" ;;
esac
