#!/bin/bash
chmod +x Full_Script.sh

#--------------# Comprobación de Sistema #---------------#
# - Verifica que el script se esta ejecutando en Arch Linux - #

if [ ! -f /etc/arch-release ]; then
    echo "este script solo funciona en Arch Linux"
    exit 1
fi

#--------------------------------------------------------#



#---------------------------------------# Privilegios Sudo #----------------------------------------#
# - Ningun comando pedira contrasena - #

sudo -v
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-nopasswd-temp
sudo chmod 440 /etc/sudoers.d/99-nopasswd-temp

# Mantener sudo activo durante todo el script
while true; do sudo -n true; sleep 50; done 2>/dev/null &
SUDO_PID=$!
trap 'kill $SUDO_PID 2>/dev/null' EXIT

#---------------------------------------------------------------------------------------------------#



#-------------------# Instalación Yay #-------------------#
# - Solo instala yay si no esta ya en el sistema - #

echo ">>> Comprobando yay..."
if ! command -v yay &> /dev/null; then
    cd /tmp && rm -rf yay-bin
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin && makepkg -si --noconfirm
fi

#---------------------------------------------------------#



#------------------# Selección de opciones #------------------#
# - Recoge todas las preferencias antes de empezar a instalar - #

while true; do
  clear
  echo "=========================================="
  echo "   ¿Deseas la instalación completa?"
  echo "=========================================="
  echo ""
  echo "1. Sí, instalación completa"
  echo "2. No, quiero elegir"
  echo "3. Cual es la diferencia?"
  while true; do
    read -p "Elige una opción (1-3): " tipo_instalacion
    case "$tipo_instalacion" in
      (1|2|3) break ;;
      (*) echo "opción no válida, inténtalo de nuevo" ;;
    esac
  done

  if [ "$tipo_instalacion" = "3" ]; then
    clear
    echo "=========================================="
    echo "        DIFERENCIAS ENTRE MODOS"
    echo "=========================================="
    echo ""
    echo "Ambos modos preguntan por:"
    echo "  • Navegador (Firefox, Chromium, Brave...)"
    echo "  • Editor de código (VSCodium, Windsurf...)"
    echo "  • Launcher de juegos (Steam, Heroic...)"
    echo ""
    echo "─────────────────────────────────────────"
    echo ""
    echo "INSTALACIÓN COMPLETA incluye además:"
    echo "  • Actualización del sistema y keyring"
    echo "  • Paquetes base (gcc, cmake, git, rust...)"
    echo "  • Apps (LibreOffice, GIMP, Discord, Blender)"
    echo "  • Fuentes (Noto, DejaVu, Fira Sans...)"
    echo "  • Audio (PipeWire, PavuControl, Cava...)"
    echo "  • Entorno Hyprland (dots-hyprland)"
    echo "  • Optimización de makepkg"
    echo "  • Software extra (Upscayl, Wine, nwg-displays)"
    echo "  • SDDM + tema SilentSDDM"
    echo "  • Fuente Monocraft"
    echo "  • Fondo de pantalla personalizado"
    echo "  • Limpieza de WMs y DMs anteriores"
    echo ""
    echo "QUIERO ELEGIR instala solo:"
    echo "  • El navegador, editor y launcher elegidos"
    echo ""
    read -p "Pulsa Enter para volver..."
  else
    break
  fi
done

# Ambas opciones preguntan navegador, editor y launcher
clear
echo "=== NAVEGADOR ==="
echo "1. Firefox"
echo "2. Chromium"
echo "3. Brave"
echo "4. Opera"
echo "5. Tor Browser"
echo "6. Zen Browser"
echo "7. Ninguno"
while true; do
  read -p "Elige una opción (1-7): " navegador
  case "$navegador" in
    (1|2|3|4|5|6|7)
      break
      ;;
    (*)
      echo "opción no válida, inténtalo de nuevo"
      ;;
  esac
done

clear
echo "=== EDITOR DE CÓDIGO ==="
echo "1. VSCodium"
echo "2. Windsurf"
echo "3. Antigravity"
echo "4. Ninguno"
while true; do
  read -p "Elige una opción (1-4): " editor
  case "$editor" in
    (1|2|3|4)
      break
      ;;
    (*)
      echo "opción no válida, inténtalo de nuevo"
      ;;
  esac
done

clear
echo "=== LAUNCHER DE JUEGOS ==="
echo "1. Steam"
echo "2. Heroic Games Launcher"
echo "3. Ambos"
echo "4. Ninguno"
while true; do
  read -p "Elige una opción (1-4): " launcher
  case "$launcher" in
    (1|2|3|4)
      break
      ;;
    (*)
      echo "opción no válida, inténtalo de nuevo"
      ;;
  esac
done

clear

export tipo_instalacion
export navegador
export editor
export launcher

#-------------------------------------------------------------#



#-----------------------------------------# Navegador #-----------------------------------------#
# - Instala el navegador seleccionado - #

echo ">>> Instalando navegador..."
case "$navegador" in
  (1) sudo pacman -S --needed firefox --noconfirm ;;
  (2) sudo pacman -S --needed chromium --noconfirm ;;
  (3) yay -S --noconfirm --needed --answerclean All --answerdiff None brave-bin ;;
  (4) yay -S --noconfirm --needed --answerclean All --answerdiff None opera ;;
  (5) yay -S --noconfirm --needed --answerclean All --answerdiff None tor-browser ;;
  (6) yay -S --noconfirm --needed --answerclean All --answerdiff None zen-browser-bin ;;
  (7) echo "sin navegador, ok" ;;
esac

#-----------------------------------------------------------------------------------------------#



#--------------------------------------------------------------# Editor de Código #---------------------------------------------------------------#
# - Instala el editor seleccionado - #

echo ">>> Instalando editor..."
case "$editor" in
  (1) env -u MAKEPKGFLAGS yay -S --noconfirm --needed --answerclean All --answerdiff None vscodium-bin --mflags '--nocheck --skipinteg' ;;
  (2) yay -S --noconfirm --needed --answerclean All --answerdiff None windsurf ;;
  (3) yay -S --noconfirm --needed --answerclean All --answerdiff None antigravity ;;
  (4) echo "sin editor, ok" ;;
esac

#-----------------------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------# Launcher de Juegos #-----------------------------------------#
# - Instala el launcher seleccionado - #

echo ">>> Instalando launcher..."
case "$launcher" in
  (1) sudo pacman -S --needed flatpak --noconfirm
     flatpak install flathub com.valvesoftware.Steam -y ;;
  (2) yay -S --noconfirm --needed --answerclean All --answerdiff None heroic-games-launcher-bin ;;
  (3) sudo pacman -S --needed flatpak --noconfirm
     flatpak install flathub com.valvesoftware.Steam -y
     yay -S --noconfirm --needed --answerclean All --answerdiff None heroic-games-launcher-bin ;;
  (4) echo "sin launcher, ok" ;;
esac

#---------------------------------------------------------------------------------------------------------#



#-----------# Secciones solo para instalación completa #------------#

if [ "$tipo_instalacion" = "1" ]; then

#-----------# Actualización de Sistema #------------#
# - Actualiza el keyring y todos los paquetes del sistema - #

echo ">>> Actualizando sistema..."
sudo pacman -Sy archlinux-keyring --noconfirm
sudo pacman -Syu --noconfirm

#---------------------------------------------------#



#-----------------------------------------------------# Instalación de Paquetes #------------------------------------------------------#
# - Instala herramientas de desarrollo, fuentes y aplicaciones base - #

echo ">>> Instalando paquetes base..."
sudo pacman -S --needed gcc cmake git curl perl wget base-devel rust go sassc libreoffice-fresh gimp discord --noconfirm
sudo pacman -S --needed blender noto-fonts ttf-dejavu ttf-liberation ttf-ubuntu-font-family ttf-fira-sans --noconfirm

#--------------------------------------------------------------------------------------------------------------------------------------#



#-------------------------------------------# Paquetes de Audio #-------------------------------------------#
# - Instala el stack de audio y control de volumen - #

echo ">>> Instalando paquetes de audio..."
yay -S --noconfirm --needed --answerclean All --answerdiff None cava pavucontrol-qt wireplumber pipewire-pulse libdbusmenu-gtk3 playerctl

#-----------------------------------------------------------------------------------------------------------#



#-----------------------------------------# Instalación de Entorno #-----------------------------------------#
# - Clona y ejecuta el setup de dots-hyprland - #

echo ">>> Instalando entorno Hyprland..."
cd ~/.cache
rm -rf dots-hyprland
git clone --depth 1 https://github.com/end-4/dots-hyprland
cd dots-hyprland
chmod +x setup
exec 3<&0
(printf '\n\n\n\nn\nyesforall\n'; sleep 5; while true; do echo "y"; sleep 2; done) | ./setup install || true
exec 0<&3 3<&-

#------------------------------------------------------------------------------------------------------------#



#--------------------------------------------------# Optimización Makepkg #---------------------------------------------------#
# - Ajusta las flags de compilacion para builds mas rapidos - #

echo ">>> Optimizando makepkg..."
cd ~
sudo sed -i '/^OPTIONS=/c\OPTIONS=(!strip docs libtool staticlibs emptydirs zipman purge !debug lto)' /etc/makepkg.conf
rm -rf ~/.cache/yay/vscodium-bin

#-----------------------------------------------------------------------------------------------------------------------------#



#---------------------------# Instalación de Software #---------------------------#
# - Instala Upscayl, gestor de pantallas y Wine - #

echo ">>> Instalando software..."
yay -S --noconfirm --needed --answerclean All --answerdiff None upscayl-bin
sudo pacman -S --needed nwg-displays --noconfirm
sudo pacman -S --needed wine --noconfirm

#---------------------------------------------------------------------------------#



#-----------# Eliminar DM anterior e instalar SDDM #-----------#
# - Borra cualquier display manager instalado previamente y lo reemplaza por SDDM - #

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

#--------------------------------------------------------------#



#--------------------------------# SDDM #---------------------------------#
# - Instala el tema SilentSDDM como pantalla de inicio de sesion - #

echo ">>> Instalando SDDM..."
cd /tmp
rm -rf SilentSDDM
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM
cd SilentSDDM
chmod +x install.sh
sudo ./install.sh

#-------------------------------------------------------------------------#



#-----------------------------------------------------# Fuente de Minecraft #-----------------------------------------------------#
# - Descarga Monocraft y la aplica en kitty, illogical-impulse y VSCodium - #

echo ">>> Instalando fuente Monocraft..."
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

echo ">>> Aplicando fondo de pantalla..."
mkdir -p "$HOME/.config/quickshell/ii/assets/images"
rm -f "$HOME/.config/quickshell/ii/assets/images/default_wallpaper.png"
curl -Lo "$HOME/.config/quickshell/ii/assets/images/default_wallpaper.png" https://github.com/Edgares100IQ/archlinux-scripts/raw/main/default_wallpaper.png

#-----------------------------------------------------------------------------------------------#



#---------------------------# Eliminar WM anterior e instalar Hyprland #----------------------------#
# - Borra cualquier gestor de ventanas previo y lo reemplaza por Hyprland - #

echo ">>> Comprobando gestor de ventanas..."
for wm in plasma-desktop gnome-shell xfwm4 openbox i3 sway bspwm dwm awesome qtile xmonad; do
  if pacman -Qs "^$wm$" &>/dev/null; then
    echo "encontrado $wm, reemplazando por hyprland..."
    sudo pacman -Rns --noconfirm $wm 2>/dev/null || true
  fi
done

sudo pacman -S --needed hyprland --noconfirm

#---------------------------------------------------------------------------------------------------#

fi  # fin de instalación completa



#--------------# Limpieza y Reinicio #---------------#
# - Elimina el permiso sudo temporal y reinicia el sistema - #

sudo rm -f /etc/sudoers.d/99-nopasswd-temp
kill $SUDO_PID 2>/dev/null

echo ""
echo "instalación completada, reiniciando en:"
for i in {10..1}; do
  echo "  $i..."
  sleep 1
done
sudo reboot

#----------------------------------------------------#
