#!/bin/bash
chmod +x Full_Script.sh

#---------------------------------------# Privilegios Sudo #----------------------------------------#
# - Ningun comando pedira contrasena - #

sudo -v
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/pacman" | sudo tee /etc/sudoers.d/99-pacman-nopasswd
sudo chmod 440 /etc/sudoers.d/99-pacman-nopasswd

#---------------------------------------------------------------------------------------------------#



#-------------------# Instalación Yay #-------------------#
# - Solo instala yay si no esta ya en el sistema - #

if ! command -v yay &> /dev/null; then
    cd /tmp && rm -rf yay-bin
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin && makepkg -si --noconfirm
fi

#---------------------------------------------------------#



#-----------------------------------------# Elegir navegador #-----------------------------------------#
# - Menu interactivo para elegir el navegador que se instalara - #

while true; do
  echo "¿Qué navegador quieres instalar?"
  echo "1) Firefox"
  echo "2) Chromium"
  echo "3) Brave"
  echo "4) Opera"
  echo "5) Tor Browser"
  echo "6) Zen Browser"
  echo "7) Ninguno"
  read -p "Elige una opción [1-7]: " navegador
  case $navegador in
    1) sudo pacman -S --needed firefox --noconfirm; break ;;
    2) sudo pacman -S --needed chromium --noconfirm; break ;;
    3) yay -S --noconfirm --needed --answerclean All --answerdiff None brave-bin; break ;;
    4) yay -S --noconfirm --needed --answerclean All --answerdiff None opera; break ;;
    5) yay -S --noconfirm --needed --answerclean All --answerdiff None tor-browser; break ;;
    6) yay -S --noconfirm --needed --answerclean All --answerdiff None zen-browser-bin; break ;;
    7) echo "sin navegador, ok"; break ;;
    *) echo "opción no válida, inténtalo de nuevo" ;;
  esac
done

#------------------------------------------------------------------------------------------------------#



#-----------# Actualización de Sistema #------------#
# - Actualiza el keyring y todos los paquetes del sistema - #

sudo pacman -Sy archlinux-keyring --noconfirm
sudo pacman -Syu --noconfirm

#---------------------------------------------------#



#-----------------------------------------------------# Instalación de Paquetes #------------------------------------------------------#
# - Instala herramientas de desarrollo, fuentes y aplicaciones base - #

sudo pacman -S --needed gcc cmake git curl perl wget base-devel rust go sassc flatpak libreoffice-fresh gimp discord --noconfirm
sudo pacman -S --needed blender noto-fonts ttf-dejavu ttf-liberation ttf-ubuntu-font-family ttf-fira-sans --noconfirm

#--------------------------------------------------------------------------------------------------------------------------------------#



#-------------------------------------------# Paquetes de Audio #-------------------------------------------#
# - Instala el stack de audio y control de volumen - #

yay -S --noconfirm --needed cava pavucontrol-qt wireplumber pipewire-pulse libdbusmenu-gtk3 playerctl

#-----------------------------------------------------------------------------------------------------------#



#--------------------------------------------# Instalación de Entorno #--------------------------------------------#
# - Clona y ejecuta el setup de dots-hyprland - #

cd ~/.cache
rm -rf dots-hyprland
git clone --depth 1 https://github.com/end-4/dots-hyprland
cd dots-hyprland
chmod +x setup
(printf '\n\n\n\nn\nyesforall\n'; sleep 5; while true; do echo "y"; sleep 2; done) | ./setup install || true

#------------------------------------------------------------------------------------------------------------------#



#--------------------------------------------------# Optimización Makepkg #---------------------------------------------------#
# - Ajusta las flags de compilacion para builds mas rapidos - #

cd ~
sudo sed -i '/^OPTIONS=/c\OPTIONS=(!strip docs libtool staticlibs emptydirs zipman purge !debug lto)' /etc/makepkg.conf
rm -rf ~/.cache/yay/vscodium-bin

#-----------------------------------------------------------------------------------------------------------------------------#



#------------------------------------------------------# Instalación de Software #------------------------------------------------------#
# - Instala Heroic, VSCodium, Steam, Upscayl y gestor de pantallas - #

yay -S --noconfirm --needed --answerclean All --answerdiff None heroic-games-launcher-bin
env -u MAKEPKGFLAGS yay -S --noconfirm --needed --answerclean All --answerdiff None vscodium-bin --mflags "--nocheck --skipinteg"
flatpak install flathub com.valvesoftware.Steam -y
yay -S --noconfirm --needed --answerclean All --answerdiff None upscayl-bin
sudo pacman -S --needed nwg-displays --noconfirm

#---------------------------------------------------------------------------------------------------------------------------------------#



#--------------------------------# SDDM #---------------------------------#
# - Instala el tema SilentSDDM como pantalla de inicio de sesion - #

cd /tmp
rm -rf SilentSDDM
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM
cd SilentSDDM
chmod +x install.sh
sudo ./install.sh

#-------------------------------------------------------------------------#



#-----------------------------------------------------# Fuente de Minecraft #-----------------------------------------------------#
# - Descarga Monocraft y la aplica en kitty, illogical-impulse y VSCodium - #

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

#---------------------------------------------------------------------------------------------------------------------------------#



#-------------------------------------# Fondo de Pantalla #-------------------------------------#
# - Reemplaza el fondo por defecto con el fondo personalizado - #

rm /home/edgar/.config/quickshell/ii/assets/images/default_wallpaper.png
cd /home/edgar/.config/quickshell/ii/assets/images/
curl -LO https://github.com/Edgares100IQ/archlinux-scripts/raw/main/default_wallpaper.png

#-----------------------------------------------------------------------------------------------#



#--------------------------------------------# Eliminar entorno DE anterior #---------------------------------------------#
# - Borra cualquier DE instalado previamente y limpia huerfanos - #

sudo pacman -Rns --noconfirm plasma plasma-desktop plasma-wayland-session kde-applications sddm 2>/dev/null || true
sudo pacman -Rns --noconfirm gnome gnome-shell gnome-session 2>/dev/null || true
sudo pacman -Rns --noconfirm xfce4 xfce4-goodies 2>/dev/null || true
sudo pacman -Rns --noconfirm lxde lxqt 2>/dev/null || true
sudo pacman -Rns --noconfirm $(pacman -Qdtq) 2>/dev/null || true

#-------------------------------------------------------------------------------------------------------------------------#



#-------------# Limpieza y Reinicio #--------------#
# - Elimina el permiso sudo temporal y reinicia el sistema - #

sudo rm -f /etc/sudoers.d/99-pacman-nopasswd

for i in {10..1}; do
  echo "Reboot en $i"
  sleep 1
done
sudo reboot

#--------------------------------------------------#
