#!/bin/bash

# Instalador de archy

set -e

REPO_URL="https://github.com/Edgares100IQ/archlinux-scripts.git"
INSTALL_DIR="$HOME/.local/share/archy"
WRAPPER="/usr/local/bin/archy"

echo ">>> Comprobando dependencias..."

# instalar yay si no está
if ! command -v yay &>/dev/null; then
    echo "    instalando yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
fi

# instalar chafa si no está
if ! command -v chafa &>/dev/null; then
    echo "    instalando chafa..."
    sudo pacman -S --needed --noconfirm chafa
fi

# instalar imagemagick si no está
if ! command -v convert &>/dev/null; then
    echo "    instalando imagemagick..."
    sudo pacman -S --needed --noconfirm imagemagick
fi

echo ">>> Clonando repositorio..."
rm -rf "$INSTALL_DIR"
git clone --depth 1 "$REPO_URL" "$INSTALL_DIR"

echo ">>> Dando permisos..."
chmod +x "$INSTALL_DIR/archy/archy.sh"
find "$INSTALL_DIR/archy/scripts" -name "*.sh" -exec chmod +x {} \;

echo ">>> Creando comando global..."
sudo tee "$WRAPPER" > /dev/null << EOF
#!/bin/bash
bash "$INSTALL_DIR/archy/archy.sh"
EOF
sudo chmod +x "$WRAPPER"

echo ""
echo "✓ archy instalado correctamente"
echo "  ejecuta 'archy' desde cualquier terminal para empezar"
