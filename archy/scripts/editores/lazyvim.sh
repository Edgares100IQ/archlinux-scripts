#!/bin/bash


echo ">>> Instalando LazyVim..."
yay -S --noconfirm --needed --answerclean All --answerdiff None neovim

# limpiar config previa si existe
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo ">>> LazyVim instalado"