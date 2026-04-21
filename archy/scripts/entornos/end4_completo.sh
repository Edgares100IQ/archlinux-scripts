#!/bin/bash


# comprobar arch linux
if [ ! -f /etc/arch-release ]; then
    echo "este script solo funciona en Arch Linux"
    exit 1
fi

# instalar yay si no está
echo ">>> Comprobando yay..."
if ! command -v yay &> /dev/null; then
    cd /tmp && rm -rf yay-bin
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin && makepkg -si --noconfirm
fi

# actualización del sistema
echo ">>> Actualizando sistema..."
sudo pacman -Sy archlinux-keyring --noconfirm
sudo pacman -Syu --noconfirm

# paquetes base
echo ">>> Instalando paquetes base..."
sudo pacman -S --needed gcc cmake git curl perl wget base-devel rust go sassc libreoffice-fresh gimp discord --noconfirm
sudo pacman -S --needed blender noto-fonts ttf-dejavu ttf-liberation ttf-ubuntu-font-family ttf-fira-sans --noconfirm

# audio
echo ">>> Instalando audio..."
yay -S --noconfirm --needed --answerclean All --answerdiff None cava pavucontrol-qt wireplumber pipewire-pulse libdbusmenu-gtk3 playerctl

# limpiar WMs anteriores
echo ">>> Comprobando gestor de ventanas..."
for wm in plasma-desktop gnome-shell xfwm4 openbox i3 sway bspwm dwm awesome qtile xmonad; do
  if pacman -Qs "^$wm$" &>/dev/null; then
    echo "encontrado $wm, reemplazando por hyprland..."
    sudo pacman -Rns --noconfirm $wm 2>/dev/null || true
  fi
done
sudo pacman -S --needed hyprland --noconfirm

# limpiar DMs anteriores e instalar SDDM
echo ">>> Comprobando display manager..."
for dm in lightdm gdm lxdm xdm greetd ly; do
  if pacman -Qs "^$dm$" &>/dev/null; then
    echo "encontrado $dm, reemplazando por sddm..."
    sudo pacman -Rns --noconfirm $dm 2>/dev/null || true
  fi
done
sudo pacman -S --needed sddm --noconfirm
sudo systemctl enable sddm
sudo rm -f /usr/share/wayland-sessions/plasmawayland.desktop
sudo rm -f /usr/share/xsessions/plasma.desktop

# instalar dots-hyprland (end-4)
echo ">>> Instalando entorno Hyprland (end-4)..."
cd ~/.cache
rm -rf dots-hyprland
git clone --depth 1 https://github.com/end-4/dots-hyprland
cd dots-hyprland
chmod +x setup
./setup install

# tema SDDM (opcional)
read -p "instalar tema SilentSDDM? [s/N]: " sddm_confirm
if [[ "$sddm_confirm" =~ ^[sS]$ ]]; then
    bash "$(dirname "$0")/sddm.sh"
fi

# optimización makepkg
echo ">>> Optimizando makepkg..."
cd ~
sudo sed -i '/^OPTIONS=/c\OPTIONS=(!strip docs libtool staticlibs emptydirs zipman purge !debug lto)' /etc/makepkg.conf
rm -rf ~/.cache/yay/vscodium-bin

# software extra
echo ">>> Instalando software extra..."
yay -S --noconfirm --needed --answerclean All --answerdiff None upscayl-bin
sudo pacman -S --needed nwg-displays --noconfirm
sudo pacman -S --needed wine --noconfirm


# fondo de pantalla
echo ">>> Aplicando fondo de pantalla..."
mkdir -p "$HOME/.config/quickshell/ii/assets/images"
rm -f "$HOME/.config/quickshell/ii/assets/images/default_wallpaper.png"
curl -Lo "$HOME/.config/quickshell/ii/assets/images/default_wallpaper.png" https://github.com/Edgares100IQ/archlinux-scripts/raw/main/default_wallpaper.png

echo ""
echo ">>> end-4 dotfiles instalado correctamente"