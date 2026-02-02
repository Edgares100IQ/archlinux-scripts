#!/bin/bash

sudo -v
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/pacman" | sudo tee /etc/sudoers.d/99-pacman-nopasswd
sudo chmod 440 /etc/sudoers.d/99-pacman-nopasswd

sudo pacman -Sy archlinux-keyring --noconfirm
sudo pacman -Syu --noconfirm

sudo pacman -S --needed gcc cmake git curl perl wget base-devel rust go sassc flatpak libreoffice-fresh gimp discord blender noto-fonts ttf-dejavu ttf-liberation ttf-ubuntu-font-family ttf-fira-sans --noconfirm

if ! command -v yay &> /dev/null; then
    cd /tmp && rm -rf yay-bin
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin && makepkg -si --noconfirm
fi

yay -S --noconfirm --needed cava pavucontrol-qt wireplumber pipewire-pulse libdbusmenu-gtk3 playerctl

cd ~/.cache
rm -rf dots-hyprland
git clone --depth 1 https://github.com/end-4/dots-hyprland
cd dots-hyprland
chmod +x setup
(printf '\n\n\n\nn\nyesforall\n'; sleep 5; while true; do echo "y"; sleep 2; done) | ./setup install || true

cd ~
sudo sed -i '/^OPTIONS=/c\OPTIONS=(!strip docs libtool staticlibs emptydirs zipman purge !debug lto)' /etc/makepkg.conf
rm -rf ~/.cache/yay/vscodium-bin

yay -S --noconfirm --needed --answerclean All --answerdiff None opera
yay -S --noconfirm --needed --answerclean All --answerdiff None heroic-games-launcher-bin
env -u MAKEPKGFLAGS yay -S --noconfirm --needed --answerclean All --answerdiff None vscodium-bin --mflags "--nocheck --skipinteg"

flatpak install flathub com.valvesoftware.Steam -y

#----------------------------------------------# Fondo de Pantalla #----------------------------------------------#
mkdir -p ~/wallpapers
cd ~/wallpapers
curl -LO https://raw.githubusercontent.com/Edgares100IQ/archlinux-scripts/main/fondo.jpg
sed -i "83c\        \"wallpaperPath\": \"$HOME/wallpapers/fondo.jpg\"," ~/.config/illogical-impulse/config.json
#-----------------------------------------------------------------------------------------------------------------#



#----------------------------------------------------# SDDM #----------------------------------------------------#
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM
cd SilentSDDM
./install.sh
#----------------------------------------------------------------------------------------------------------------#



#--------------------------------------------# Fuente de Minecraft #--------------------------------------------#
mkdir -p ~/.local/share/fonts
wget https://github.com/IdreesInc/Monocraft/releases/latest/download/Monocraft.ttc -P ~/.local/share/fonts/
fc-cache -fv

sed -i '2c\font_family Monocraft' ~/.config/kitty/kitty.conf
sed -i '26c\      "main": "Monocraft",' ~/.config/illogical-impulse/config.json
sed -i '27c\      "monospace": "Monocraft",' ~/.config/illogical-impulse/config.json
sed -i '28c\      "numbers": "Monocraft",' ~/.config/illogical-impulse/config.json
sed -i '30c\      "title": "Monocraft"' ~/.config/illogical-impulse/config.json
echo '{
    "editor.fontFamily": "'\''Monocraft'\''",
    "editor.fontSize": 14,
    "editor.fontLigatures": true,
    "security.workspace.trust.untrustedFiles": "open",
    "material-code.primaryColor": "#3355CB"
}' > ~/.config/VSCodium/User/settings.json
#---------------------------------------------------------------------------------------------------------------#

sudo rm -f /etc/sudoers.d/99-pacman-nopasswd

for i in {10..1}; do
  echo "Reboot en $i"
  sleep 1
done
sudo reboot
