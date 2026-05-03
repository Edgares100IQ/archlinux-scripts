# Archy v3

An interactive post-installer for Arch Linux with Hyprland, written in pure Bash.

![Archy demo](https://raw.githubusercontent.com/Edgares100IQ/archlinux-scripts/main/archy/pato.png)

## What is Archy?

Archy is a post-installer script that helps you set up a full Arch Linux + Hyprland environment after a fresh install. It provides an interactive arrow-key menu to install desktop environments, programs, and utilities — no manual package hunting required.

## Features

- 🖱️ Interactive arrow-key navigation menus
- 🌍 Multilingual support: Spanish, English, French, German
- 🖼️ Sixel image rendering with automatic terminal detection (fallback to chafa)
- 🖥️ Desktop environment installers: end-4 dotfiles, imperative-dots, HyDE
- 🌐 Browsers: Firefox, Chromium, Brave, Opera, Tor, Zen
- 💻 Code editors: VSCodium, Windsurf, Antigravity, LazyVim
- 🎮 Game launchers: Steam, Heroic Games Launcher
- ⛏️ Games: Minecraft (official + TLauncher), Prism Launcher, CurseForge, Modrinth
- 🛠️ Utilities: AnyDesk, Timeshift, CUPS, KeePassXC, Thunar, LibreOffice
- 💬 Communication: Discord, Telegram, WhatsApp, Spotify, Zoom, Element
- 🗑️ Uninstall section with confirmation for all installed packages
- 🔄 Self-update system

## Requirements

- Arch Linux (fresh install recommended)
- Internet connection
- `git` and `base-devel` installed

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/Edgares100IQ/archlinux-scripts/main/install-archy.sh | bash
```

This will automatically install dependencies (`yay`, `chafa`, `imagemagick`) if not already present.

## Usage

After installation, run from any terminal:

```bash
archy
```

## What gets installed with sudo?

Archy uses `sudo` for `pacman` commands and to create the `/usr/local/bin/archy` wrapper. AUR packages are installed via `yay` without root. You can review every script in `archy/scripts/` before running.

## Project structure

```
archy/
├── archy.sh              # main script
├── pato.png              # logo
└── scripts/
    ├── idioma/           # language files (es, en, fr, de)
    ├── entornos/         # desktop environment installers
    ├── navegadores/      # browser installers
    ├── editores/         # code editor installers
    ├── launchers/        # game launcher installers
    ├── juegos/           # game installers
    ├── utilidades/       # utility installers
    └── comunicacion/     # communication app installers
```

## License

MIT — see [LICENSE](LICENSE)
