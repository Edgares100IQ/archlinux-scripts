#!/bin/bash

SCRIPT_DIR="$HOME/.local/share/archy"

run_script() {
    local script="$1"
    if [ -f "$script" ]; then
        chmod +x "$script"
        bash "$script"
    else
        echo "script no encontrado: $script"
        read -p "pulsa enter para continuar..."
    fi
}

logo() {
    clear
    echo "==================================================================="
    echo "                                                                   "
    echo "                          ████████                          "
    echo "                      ████████████████                      "
    echo "                  ████████████████████████                  "
    echo "                ████████████████████████████                "
    echo "              ████████████████████████████████              "
    echo "            ████████████████████████████████████            "
    echo "            ████████████████████████████████████            "
    echo "            ██████      ████████████      ██████            "
    echo "            ██████      ████████████      ██████            "
    echo "            ██████      ████████████      ██████            "
    echo "            ████████████████████████████████████            "
    echo "            ████████████████████████████████████            "
    echo "            ██████    ████████████████    ██████            "
    echo "        ███████████                      ███████████        "
    echo "      ████████████████████████████████████████████████      "
    echo "  ████████████████████████████████████████████████████████  "
    echo "  ████████████████████████████████████████████████████████  "
    echo "  ██████████    ████████████████████████████    ██████████  "
    echo "  ██████████      ████████████████████████      ██████████  "
    echo "  ██████████      ████████████████████████      ██████████  "
    echo "                  ██████            ██████                  "
    echo "                  ██████            ██████                  "
    echo "              ████████████        ████████████              "
    echo "              ████████████        ████████████              "
    echo "              ████████████        ████████████              "
    echo "                                                                   "
    echo " ¡Hola! Soy Archy, dime qué quieres y yo lo instalo"
    echo "                                                                   "
    echo "==================================================================="
    echo ""
}

# ── navegador ──────────────────────────────────────────────────
menu_navegador() {
    while true; do
        logo
        echo "===== Navegador ====="
        echo "1. firefox"
        echo "2. chromium"
        echo "3. brave"
        echo "4. opera"
        echo "5. tor browser"
        echo "6. zen browser"
        echo "7. volver"
        read -p "Elige una opcion: " op
        case "$op" in
            1) run_script "$SCRIPT_DIR/scripts/navegadores/firefox.sh"; break ;;
            2) run_script "$SCRIPT_DIR/scripts/navegadores/chromium.sh"; break ;;
            3) run_script "$SCRIPT_DIR/scripts/navegadores/brave.sh"; break ;;
            4) run_script "$SCRIPT_DIR/scripts/navegadores/opera.sh"; break ;;
            5) run_script "$SCRIPT_DIR/scripts/navegadores/tor.sh"; break ;;
            6) run_script "$SCRIPT_DIR/scripts/navegadores/zen.sh"; break ;;
            7) break ;;
            *) echo "opcion no valida" ;;
        esac
    done
}

# ── editor de código ───────────────────────────────────────────
menu_editor() {
    while true; do
        logo
        echo "===== Editor de codigo ====="
        echo "1. vscodium"
        echo "2. windsurf"
        echo "3. antigravity"
        echo "4. volver"
        read -p "Elige una opcion: " op
        case "$op" in
            1) run_script "$SCRIPT_DIR/scripts/editores/vscodium.sh"; break ;;
            2) run_script "$SCRIPT_DIR/scripts/editores/windsurf.sh"; break ;;
            3) run_script "$SCRIPT_DIR/scripts/editores/antigravity.sh"; break ;;
            4) break ;;
            *) echo "opcion no valida" ;;
        esac
    done
}

# ── launcher de juegos ─────────────────────────────────────────
menu_launcher() {
    while true; do
        logo
        echo "===== Launcher de juegos ====="
        echo "1. steam"
        echo "2. heroic games launcher"
        echo "3. ambos"
        echo "4. volver"
        read -p "Elige una opcion: " op
        case "$op" in
            1) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh"; break ;;
            2) run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh"; break ;;
            3) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh"
               run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh"; break ;;
            4) break ;;
            *) echo "opcion no valida" ;;
        esac
    done
}

# ── programas ──────────────────────────────────────────────────
menu_programas() {
    while true; do
        logo
        echo "===== Programas ====="
        echo "1. navegador"
        echo "2. editor de codigo"
        echo "3. launcher de juegos"
        echo "4. volver"
        read -p "Elige una opcion: " op
        case "$op" in
            1) menu_navegador ;;
            2) menu_editor ;;
            3) menu_launcher ;;
            4) break ;;
            *) echo "opcion no valida" ;;
        esac
    done
}

# ── entorno de escritorio ──────────────────────────────────────
menu_entorno() {
    while true; do
        logo
        echo "===== Entorno de escritorio ====="
        echo "1. end-4 dotfiles"
        echo "2. volver"
        read -p "Elige una opcion: " op
        case "$op" in
            1) run_script "$SCRIPT_DIR/scripts/end4_completo.sh"; break ;;
            2) break ;;
            *) echo "opcion no valida" ;;
        esac
    done
}

# ── instalaciones personalizadas ───────────────────────────────
menu_personalizadas() {
    while true; do
        logo
        echo "===== Instalaciones personalizadas ====="
        echo "1. entorno de escritorio"
        echo "2. programas"
        echo "3. salir"
        read -p "Elige una opcion: " op
        case "$op" in
            1) menu_entorno ;;
            2) menu_programas ;;
            3) break ;;
            *) echo "opcion no valida" ;;
        esac
    done
}

# ── instalaciones predeterminadas ─────────────────────────────
menu_predeterminadas() {
    while true; do
        logo
        echo "===== Instalaciones predeterminadas ====="
        echo "1. instalacion predeterminada end-4 dotfiles"
        echo "2. salir"
        read -p "Elige una opcion: " op
        case "$op" in
            1) dotfiles="end-4 dotfiles" ;;
            2) break ;;
            *) echo "opcion no valida"; continue ;;
        esac

        logo
        echo "===== Instalacion predeterminada $dotfiles ====="
        echo "Elige tu navegador:"
        echo "1. firefox"
        echo "2. chromium"
        echo "3. brave"
        echo "4. opera"
        echo "5. tor browser"
        echo "6. zen browser"
        echo "7. ninguno"
        read -p "Elige una opcion: " op_nav

        logo
        echo "===== Instalacion predeterminada $dotfiles ====="
        echo "Elige tu editor de codigo:"
        echo "1. vscodium"
        echo "2. windsurf"
        echo "3. antigravity"
        echo "4. ninguno"
        read -p "Elige una opcion: " op_edit

        logo
        echo "===== Instalacion predeterminada $dotfiles ====="
        echo "Elige tu launcher de juegos:"
        echo "1. steam"
        echo "2. heroic games launcher"
        echo "3. ambos"
        echo "4. ninguno"
        read -p "Elige una opcion: " op_launch

        # resumen
        logo
        echo "======================================="
        echo "RESUMEN DE INSTALACION:"
        echo "- Dotfiles: $dotfiles"
        case "$op_nav" in
            1) echo "- Navegador: firefox" ;;
            2) echo "- Navegador: chromium" ;;
            3) echo "- Navegador: brave" ;;
            4) echo "- Navegador: opera" ;;
            5) echo "- Navegador: tor browser" ;;
            6) echo "- Navegador: zen browser" ;;
        esac
        case "$op_edit" in
            1) echo "- Editor: vscodium" ;;
            2) echo "- Editor: windsurf" ;;
            3) echo "- Editor: antigravity" ;;
        esac
        case "$op_launch" in
            1) echo "- Launcher: steam" ;;
            2) echo "- Launcher: heroic games launcher" ;;
            3) echo "- Launcher: steam + heroic" ;;
        esac
        echo "======================================="
        read -p "pulsa enter para comenzar..."

        # instalar
        run_script "$SCRIPT_DIR/scripts/end4_completo.sh"

        case "$op_nav" in
            1) run_script "$SCRIPT_DIR/scripts/navegadores/firefox.sh" ;;
            2) run_script "$SCRIPT_DIR/scripts/navegadores/chromium.sh" ;;
            3) run_script "$SCRIPT_DIR/scripts/navegadores/brave.sh" ;;
            4) run_script "$SCRIPT_DIR/scripts/navegadores/opera.sh" ;;
            5) run_script "$SCRIPT_DIR/scripts/navegadores/tor.sh" ;;
            6) run_script "$SCRIPT_DIR/scripts/navegadores/zen.sh" ;;
        esac
        case "$op_edit" in
            1) run_script "$SCRIPT_DIR/scripts/editores/vscodium.sh" ;;
            2) run_script "$SCRIPT_DIR/scripts/editores/windsurf.sh" ;;
            3) run_script "$SCRIPT_DIR/scripts/editores/antigravity.sh" ;;
        esac
        case "$op_launch" in
            1) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh" ;;
            2) run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh" ;;
            3) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh"
               run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh" ;;
        esac

        echo ""
        echo "instalacion completada, reiniciando en:"
        for i in {10..1}; do echo "  $i..."; sleep 1; done
        sudo reboot
        break
    done
}

# ── menú principal ─────────────────────────────────────────────
while true; do
    logo
    echo "1. instalaciones predeterminadas"
    echo "2. instalaciones personalizadas"
    echo "3. salir"
    read -p "Elige una opcion: " opcion
    case "$opcion" in
        1) menu_predeterminadas ;;
        2) menu_personalizadas ;;
        3) exit 0 ;;
        *) echo "opcion no valida" ;;
    esac
done
