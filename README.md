<p align="center">
  <pre align="center">
                      ████████
                  ████████████████
              ████████████████████████
            ████████████████████████████
          ████████████████████████████████
        ████████████████████████████████████
        ████████████████████████████████████
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

<h1 align="center">Archy</h1>
<p align="center">Post-instalador interactivo para Arch Linux</p>

---

Acabas de instalar Arch Linux. Ahora toca lo tedioso: instalar yay, configurar el entorno, buscar los paquetes uno por uno, acordarte de qué flags necesita cada cosa...

Archy se encarga de todo eso. Abres el menú, eliges lo que quieres, y te vas a hacer otra cosa.

## Instalación

```bash
cd ~/Escritorio
curl -O https://raw.githubusercontent.com/Edgares100IQ/archlinux-scripts/main/install-archy.sh
bash install-archy.sh
```

A partir de ahí ejecutas `archy` desde cualquier terminal.

## Qué hace

Archy tiene dos modos:

**Instalación predeterminada** — eliges dotfiles, navegador, editor y launcher, y Archy monta todo el entorno de cero sin que tengas que tocar nada más.

**Instalación personalizada** — vas eligiendo programa por programa lo que quieres instalar. Puedes volver al menú y seguir instalando cosas sin que se cierre.

## Estructura

```
~/.local/share/archy/
  archy.sh
  scripts/
    navegadores/
    editores/
    launchers/
    end4_completo.sh
```

Cada script funciona de forma independiente. Si algo falla solo falla ese, el resto no se ve afectado.

## Requisitos

- Arch Linux
- Conexión a internet
- `git` instalado

> Archy instala `yay` automáticamente si no lo tienes.

---

<p align="center">hecho para no perder el tiempo</p>
