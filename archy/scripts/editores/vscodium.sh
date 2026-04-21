#!/bin/bash


echo ">>> Instalando VSCodium..."
env -u MAKEPKGFLAGS yay -S --noconfirm --needed --answerclean All --answerdiff None vscodium-bin --mflags '--nocheck --skipinteg'

echo ">>> VSCodium instalado"