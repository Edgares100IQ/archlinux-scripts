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