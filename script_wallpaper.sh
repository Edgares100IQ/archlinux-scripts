mkdir -p ~/wallpapers
cd ~/wallpapers
curl -LO https://raw.githubusercontent.com/Edgares100IQ/archlinux-scripts/main/fondo.jpg
sed -i "83c\        \"wallpaperPath\": \"$HOME/wallpapers/fondo.jpg\"," ~/.config/illogical-impulse/config.json