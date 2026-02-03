#!/bin/bash
chmod +x Full_Script.sh

#----------------------------------------------# Privilegios Sudo #----------------------------------------------#
sudo -v
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/pacman" | sudo tee /etc/sudoers.d/99-pacman-nopasswd
sudo chmod 440 /etc/sudoers.d/99-pacman-nopasswd
#-----------------------------------------------------------------------------------------------------------------#



#-------------------------------------------# Actualización de Sistema #-------------------------------------------#
sudo pacman -Sy archlinux-keyring --noconfirm
sudo pacman -Syu --noconfirm
#-----------------------------------------------------------------------------------------------------------------#



#-------------------------------------------# Instalación de Paquetes #-------------------------------------------#
sudo pacman -S --needed gcc cmake git curl perl wget base-devel rust go sassc flatpak libreoffice-fresh gimp discord blender noto-fonts ttf-dejavu ttf-liberation ttf-ubuntu-font-family ttf-fira-sans --noconfirm
#-----------------------------------------------------------------------------------------------------------------#



#------------------------------------------------# Instalación Yay #------------------------------------------------#
if ! command -v yay &> /dev/null; then
    cd /tmp && rm -rf yay-bin
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin && makepkg -si --noconfirm
fi
#-----------------------------------------------------------------------------------------------------------------#



#----------------------------------------------# Paquetes de Audio #----------------------------------------------#
yay -S --noconfirm --needed cava pavucontrol-qt wireplumber pipewire-pulse libdbusmenu-gtk3 playerctl
#-----------------------------------------------------------------------------------------------------------------#



#--------------------------------------------# Instalación de Entorno #--------------------------------------------#
cd ~/.cache
rm -rf dots-hyprland
git clone --depth 1 https://github.com/end-4/dots-hyprland
cd dots-hyprland
chmod +x setup
(printf '\n\n\n\nn\nyesforall\n'; sleep 5; while true; do echo "y"; sleep 2; done) | ./setup install || true
#-----------------------------------------------------------------------------------------------------------------#



#--------------------------------------------# Optimización Makepkg #--------------------------------------------#
cd ~
sudo sed -i '/^OPTIONS=/c\OPTIONS=(!strip docs libtool staticlibs emptydirs zipman purge !debug lto)' /etc/makepkg.conf
rm -rf ~/.cache/yay/vscodium-bin
#-----------------------------------------------------------------------------------------------------------------#



#-------------------------------------------# Instalación de Software #-------------------------------------------#
yay -S --noconfirm --needed --answerclean All --answerdiff None opera
yay -S --noconfirm --needed --answerclean All --answerdiff None heroic-games-launcher-bin
env -u MAKEPKGFLAGS yay -S --noconfirm --needed --answerclean All --answerdiff None vscodium-bin --mflags "--nocheck --skipinteg"
flatpak install flathub com.valvesoftware.Steam -y
#-----------------------------------------------------------------------------------------------------------------#



#----------------------------------------------# Fondo de Pantalla #----------------------------------------------#
rm ~/.config/illogical-impulse/config.json
mkdir -p ~/wallpapers
cd ~/wallpapers
curl -LO https://raw.githubusercontent.com/Edgares100IQ/archlinux-scripts/main/fondo.jpg
mkdir -p ~/.config/illogical-impulse
CONFIG_FILE=~/.config/illogical-impulse/config.json
WP_REAL_PATH="$HOME/wallpapers/fondo.jpg"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "{\"wallpaperPath\": \"$WP_REAL_PATH\"}" > "$CONFIG_FILE"
else
    if grep -q "wallpaperPath" "$CONFIG_FILE"; then
        sed -i "s|\"wallpaperPath\": \".*\"|\"wallpaperPath\": \"$WP_REAL_PATH\"|" "$CONFIG_FILE"
    else
        if grep -q "^{}$" "$CONFIG_FILE"; then
             echo "{\"wallpaperPath\": \"$WP_REAL_PATH\"}" > "$CONFIG_FILE"
        else
             sed -i "s|}|  ,\"wallpaperPath\": \"$WP_REAL_PATH\"\n}|" "$CONFIG_FILE"
        fi
    fi
fi
#-----------------------------------------------------------------------------------------------------------------#



#----------------------------------------------------# SDDM #----------------------------------------------------#
cd /tmp
rm -rf SilentSDDM
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM
cd SilentSDDM
chmod +x install.sh
sudo ./install.sh
#----------------------------------------------------------------------------------------------------------------#



#--------------------------------------------# Fuente de Minecraft #--------------------------------------------#
mkdir -p ~/.local/share/fonts
wget -q https://github.com/IdreesInc/Monocraft/releases/latest/download/Monocraft.ttc -O ~/.local/share/fonts/Monocraft.ttc
fc-cache -fv

[ -f ~/.config/kitty/kitty.conf ] && sed -i 's/^font_family .*/font_family Monocraft/' ~/.config/kitty/kitty.conf
if [ -f ~/.config/illogical-impulse/config.json ]; then
    sed -i 's/^\([[:space:]]*\)"main": ".*"/\1"main": "Monocraft"/' ~/.config/illogical-impulse/config.json
    sed -i 's/^\([[:space:]]*\)"monospace": ".*"/\1"monospace": "Monocraft"/' ~/.config/illogical-impulse/config.json
    sed -i 's/^\([[:space:]]*\)"numbers": ".*"/\1"numbers": "Monocraft"/' ~/.config/illogical-impulse/config.json
    sed -i 's/^\([[:space:]]*\)"title": ".*"/\1"title": "Monocraft"/' ~/.config/illogical-impulse/config.json
fi

mkdir -p ~/.config/VSCodium/User
echo '{
    "editor.fontFamily": "'\''Monocraft'\''",
    "editor.fontSize": 14,
    "editor.fontLigatures": true,
    "security.workspace.trust.untrustedFiles": "open",
    "material-code.primaryColor": "#3355CB"
}' > ~/.config/VSCodium/User/settings.json
#---------------------------------------------------------------------------------------------------------------#



#----------------------------------------------# Limpieza y Reinicio #----------------------------------------------#
sudo rm -f /etc/sudoers.d/99-pacman-nopasswd

for i in {10..1}; do
  echo "Reboot en $i"
  sleep 1
done
sudo reboot
#-----------------------------------------------------------------------------------------------------------------#
