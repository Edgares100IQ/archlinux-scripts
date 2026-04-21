#!/bin/bash


echo ">>> Instalando tema SilentSDDM..."
cd /tmp
rm -rf SilentSDDM
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM
cd SilentSDDM
chmod +x install.sh
sudo ./install.sh

echo ">>> SilentSDDM instalado"