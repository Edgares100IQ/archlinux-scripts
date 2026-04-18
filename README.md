<p align="center">
  <pre align="center">
                        ████████████
                    ████████████████████
                  ████████████████████████
                ████████████████████████████
              ████████████████████████████████
              ████████████████████████████████
            ██████      ████████████      ██████
            ██████      ████████████      ██████
            ██████      ████████████      ██████
            ████████████████████████████████████
            ████████████████████████████████████
            ██████    ████████████████    ██████
        ███████████                      ███████████
      ████████████████████████████████████████████████
  ████████████████████████████████████████████████████████
  ████████████████████████████████████████████████████████
  ██████████    ████████████████████████████    ██████████
  ██████████      ████████████████████████      ██████████
  ██████████      ████████████████████████      ██████████
                  ██████            ██████
                  ██████            ██████
              ████████████        ████████████
              ████████████        ████████████
              ████████████        ████████████  

  </pre>
</p>

<h1 align="center">ARCHY</h1>
<p align="center">Post-instalador interactivo para Arch Linux</p>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat&logo=arch-linux&logoColor=white"/>
  <img src="https://img.shields.io/badge/Hyprland-58E1FF?style=flat"/>
  <img src="https://img.shields.io/badge/end--4_dotfiles-white?style=flat"/>
  <img src="https://img.shields.io/badge/bash-4EAA25?style=flat&logo=gnubash&logoColor=white"/>
  <img src="https://img.shields.io/badge/version-2.0-gray?style=flat"/>
</p>

---

Acabas de instalar Arch Linux. Ahora toca lo tedioso: instalar yay, configurar el entorno, buscar los paquetes uno por uno, acordarte de qué flags necesita cada cosa...

Archy se encarga de todo eso. Abres el menú, eliges lo que quieres, y te vas a hacer otra cosa.

## Instalación

```bash
curl -O https://raw.githubusercontent.com/Edgares100IQ/archlinux-scripts/main/install-archy.sh
bash install-archy.sh
```

A partir de ahí ejecuta `archy` desde cualquier terminal.

## Modos

**Instalación predeterminada** — eliges dotfiles, navegador, editor y launcher, y Archy monta todo el entorno de cero sin que tengas que tocar nada más.

**Instalación personalizada** — vas eligiendo programa por programa lo que quieres instalar. Puedes volver al menú y seguir instalando cosas sin que se cierre.

## Qué puede instalar

**Entornos**
- end-4 dotfiles (Hyprland + SDDM + audio)
- Tema SDDM: SilentSDDM

**Navegadores**
- Firefox, Chromium, Brave, Opera, Tor Browser, Zen Browser

**Editores de código**
- VSCodium, Windsurf, Antigravity, LazyVim

**Launchers de juegos**
- Steam, Heroic Games Launcher

## Novedades v2.0

- **Soporte multiidioma** — español, english, français, deutsch. Se guarda en local y se puede cambiar desde ajustes en cualquier momento
- **LazyVim** añadido como opción de editor
- **SilentSDDM** ahora es un script independiente, se puede instalar solo o durante la instalación predeterminada
- **Menú de ajustes** para cambiar el idioma sin reinstalar
- **Reboot con confirmación** — ya no reinicia automáticamente al terminar

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
- `git` instalado

> Archy instala `yay` automáticamente si no lo tienes.

---

<p align="center">hecho para no perder el tiempo</p>
