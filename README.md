<h1 align="center">ARCHY</h1>
<p align="center">Post-instalador interactivo para Arch Linux</p>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat&logo=arch-linux&logoColor=white"/>
  <img src="https://img.shields.io/badge/Hyprland-58E1FF?style=flat"/>
  <img src="https://img.shields.io/badge/bash-4EAA25?style=flat&logo=gnubash&logoColor=white"/>
  <img src="https://img.shields.io/badge/version-2.0-gray?style=flat"/>
</p>

---

Acabas de instalar Arch Linux. Ahora toca lo tedioso: instalar yay, configurar el entorno, buscar los paquetes uno por uno...

Archy se encarga de todo eso. Abres el menú, eliges lo que quieres, y te vas a hacer otra cosa.

## Instalación

```bash
sudo pacman -S --needed git --noconfirm && curl -fsSL https://raw.githubusercontent.com/Edgares100IQ/archlinux-scripts/main/install-archy.sh | bash
```

A partir de ahí ejecuta `archy` desde cualquier terminal.

## Qué puede hacer

**🖥️ Entornos de escritorio**
- end-4 dotfiles
- imperative-dots
- HyDE
- Tema SDDM: SilentSDDM (instalable por separado)

**🌐 Navegadores**
- Firefox, Chromium, Brave, Opera, Tor Browser, Zen Browser

**💻 Editores de código**
- VSCodium, Windsurf, Antigravity, LazyVim

**🎮 Launchers de juegos**
- Steam, Heroic Games Launcher

**🗑️ Desinstalar programas**
- Desinstala cualquier programa instalado con Archy desde el mismo menú

## Modos

**Instalación completa** — eliges dotfiles, navegador, editor y launcher, y Archy monta todo el entorno de cero.

**Instalaciones** — vas eligiendo programa por programa. Puedes volver al menú y seguir instalando cosas sin que se cierre.

## Idiomas

Archy pregunta el idioma la primera vez que lo ejecutas y lo guarda. Puedes cambiarlo en cualquier momento desde ajustes.

- 🇪🇸 Español
- 🇬🇧 English
- 🇫🇷 Français
- 🇩🇪 Deutsch

## Estructura

```
~/.local/share/archy/
  archy.sh
  scripts/
    navegadores/
    editores/
    launchers/
    entornos/
    idioma/
      es.sh  en.sh  fr.sh  de.sh
```

Cada script funciona de forma independiente. Si algo falla solo falla ese, el resto no se ve afectado.

## Requisitos

- Arch Linux
- Conexión a internet
- `git` instalado (el one-liner lo instala automáticamente)

> Archy instala `yay` automáticamente si no lo tienes.

## Novedades v2.0

- **Soporte multiidioma** — ES, EN, FR, DE
- **3 entornos** — end-4, imperative-dots y HyDE
- **Desinstalar programas** desde el mismo menú
- **LazyVim** añadido como opción de editor
- **SilentSDDM** como script independiente
- **Menú de ajustes** para cambiar el idioma
- **Reboot con confirmación**
- **Instalación en un solo comando**

---

<p align="center">hecho para no perder el tiempo</p>
