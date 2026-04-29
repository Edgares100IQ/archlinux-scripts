#!/bin/bash
echo "=== Interfaces de red ==="
ip addr show
echo ""
echo "=== DNS configurado ==="
cat /etc/resolv.conf
echo ""
echo "=== Tabla de rutas ==="
ip route
echo ""
echo "=== Conexiones activas ==="
ss -tuln
read -p "pulsa enter para continuar..."
