#!/bin/bash
if ! command -v htop &>/dev/null; then
    sudo pacman -S --needed htop --noconfirm
fi
htop
