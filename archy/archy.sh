#!/bin/bash

SCRIPT_DIR="$HOME/.local/share/archy/archy"
LANG_FILE="$HOME/.local/share/archy/lang"
I18N_DIR="$SCRIPT_DIR/scripts/idioma"

# ── idioma ─────────────────────────────────────────────────────
select_language() {
    echo ""
    echo "Selecciona tu idioma / Select your language / Choisissez votre langue / Sprache wählen:"
    echo "1. Español"
    echo "2. English"
    echo "3. Français"
    echo "4. Deutsch"
    read -p "> " lang_op
    case "$lang_op" in
        1) echo "1" > "$LANG_FILE" ;;
        2) echo "2" > "$LANG_FILE" ;;
        3) echo "3" > "$LANG_FILE" ;;
        4) echo "4" > "$LANG_FILE" ;;
        *) echo "1" > "$LANG_FILE" ;;
    esac
}

load_language() {
    if [ ! -f "$LANG_FILE" ]; then
        select_language
    fi
    local lang
    lang=$(cat "$LANG_FILE")
    case "$lang" in
        1) source "$I18N_DIR/es.sh" ;;
        2) source "$I18N_DIR/en.sh" ;;
        3) source "$I18N_DIR/fr.sh" ;;
        4) source "$I18N_DIR/de.sh" ;;
        *) source "$I18N_DIR/es.sh" ;;
    esac
}

# ── utilidades ─────────────────────────────────────────────────
run_script() {
    local script="$1"
    if [ -f "$script" ]; then
        chmod +x "$script"
        bash "$script"
    else
        echo "$MSG_SCRIPT_NOT_FOUND$script"
        read -p "$MSG_PRESS_ENTER"
    fi
}

logo() {
    clear
    echo "==================================================================="
    echo "                                                                   "
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
    echo " $MSG_HELLO"
    echo "                                                                   "
    echo "==================================================================="
    echo ""
}

# ── navegador ──────────────────────────────────────────────────
menu_navegador() {
    while true; do
        logo
        echo "===== $MSG_MENU_BROWSER_TITLE ====="
        echo "1. 🦊 firefox"
        echo "2. 🔵 chromium"
        echo "3. 🦁 brave"
        echo "4. 🎭 opera"
        echo "5. 🧅 tor browser"
        echo "6. 🌀 zen browser"
        echo "7. $MSG_BACK"
        read -p "$MSG_CHOOSE" op
        case "$op" in
            1) run_script "$SCRIPT_DIR/scripts/navegadores/firefox.sh"; break ;;
            2) run_script "$SCRIPT_DIR/scripts/navegadores/chromium.sh"; break ;;
            3) run_script "$SCRIPT_DIR/scripts/navegadores/brave.sh"; break ;;
            4) run_script "$SCRIPT_DIR/scripts/navegadores/opera.sh"; break ;;
            5) run_script "$SCRIPT_DIR/scripts/navegadores/tor.sh"; break ;;
            6) run_script "$SCRIPT_DIR/scripts/navegadores/zen.sh"; break ;;
            7) break ;;
            *) echo "$MSG_INVALID" ;;
        esac
    done
}

# ── editor de código ───────────────────────────────────────────
menu_editor() {
    while true; do
        logo
        echo "===== $MSG_MENU_EDITOR_TITLE ====="
        echo "1. 💙 vscodium"
        echo "2. 🌊 windsurf"
        echo "3. ⚡ antigravity"
        echo "4. 💤 lazyvim"
        echo "5. $MSG_BACK"
        read -p "$MSG_CHOOSE" op
        case "$op" in
            1) run_script "$SCRIPT_DIR/scripts/editores/vscodium.sh"; break ;;
            2) run_script "$SCRIPT_DIR/scripts/editores/windsurf.sh"; break ;;
            3) run_script "$SCRIPT_DIR/scripts/editores/antigravity.sh"; break ;;
            4) run_script "$SCRIPT_DIR/scripts/editores/lazyvim.sh"; break ;;
            5) break ;;
            *) echo "$MSG_INVALID" ;;
        esac
    done
}

# ── launcher de juegos ─────────────────────────────────────────
menu_launcher() {
    while true; do
        logo
        echo "===== $MSG_MENU_LAUNCHER_TITLE ====="
        echo "1. 🎮 steam"
        echo "2. 🦸 heroic games launcher"
        echo "3. $MSG_BOTH"
        echo "4. $MSG_BACK"
        read -p "$MSG_CHOOSE" op
        case "$op" in
            1) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh"; break ;;
            2) run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh"; break ;;
            3) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh"
               run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh"; break ;;
            4) break ;;
            *) echo "$MSG_INVALID" ;;
        esac
    done
}

# ── programas ──────────────────────────────────────────────────
menu_programas() {
    while true; do
        logo
        echo "===== $MSG_MENU_PROGRAMS_TITLE ====="
        echo "1. 🌐 $MSG_MENU_PROGRAMS_1"
        echo "2. 💻 $MSG_MENU_PROGRAMS_2"
        echo "3. 🎮 $MSG_MENU_PROGRAMS_3"
        echo "4. $MSG_BACK"
        read -p "$MSG_CHOOSE" op
        case "$op" in
            1) menu_navegador ;;
            2) menu_editor ;;
            3) menu_launcher ;;
            4) break ;;
            *) echo "$MSG_INVALID" ;;
        esac
    done
}

# ── entorno de escritorio ──────────────────────────────────────
menu_entorno() {
    while true; do
        logo
        echo "===== $MSG_MENU_ENTORNO_TITLE ====="
        echo "1. 🖥️  $MSG_MENU_ENTORNO_1"
        echo "2. 🖥️  $MSG_MENU_ENTORNO_2"
        echo "3. 🖥️  $MSG_MENU_ENTORNO_3"
        echo "4. 🎨 $MSG_MENU_ENTORNO_4"
        echo "5. $MSG_BACK"
        read -p "$MSG_CHOOSE" op
        case "$op" in
            1) run_script "$SCRIPT_DIR/scripts/entornos/end4_completo.sh"; break ;;
            2) run_script "$SCRIPT_DIR/scripts/entornos/imperative-dots.sh"; break ;;
            3) run_script "$SCRIPT_DIR/scripts/entornos/hyde.sh"; break ;;
            4) run_script "$SCRIPT_DIR/scripts/entornos/sddm.sh"; break ;;
            5) break ;;
            *) echo "$MSG_INVALID" ;;
        esac
    done
}

# ── instalaciones personalizadas ───────────────────────────────
menu_personalizadas() {
    while true; do
        logo
        echo "===== $MSG_MENU_CUSTOM_TITLE ====="
        echo "1. $MSG_MENU_CUSTOM_1"
        echo "2. $MSG_MENU_CUSTOM_2"
        echo "3. $MSG_BACK"
        read -p "$MSG_CHOOSE" op
        case "$op" in
            1) menu_entorno ;;
            2) menu_programas ;;
            3) break ;;
            *) echo "$MSG_INVALID" ;;
        esac
    done
}

# ── ajustes ────────────────────────────────────────────────────
menu_ajustes() {
    while true; do
        logo
        echo "===== $MSG_MENU_SETTINGS_TITLE ====="
        echo "1. $MSG_MENU_SETTINGS_1"
        echo "2. $MSG_BACK"
        read -p "$MSG_CHOOSE" op
        case "$op" in
            1)
                rm -f "$LANG_FILE"
                select_language
                load_language
                ;;
            2) break ;;
            *) echo "$MSG_INVALID" ;;
        esac
    done
}

# ── instalaciones predeterminadas ─────────────────────────────
menu_predeterminadas() {
    while true; do
        logo
        echo "===== $MSG_MENU_DEFAULT_TITLE ====="
        echo "1. $MSG_MENU_DEFAULT_1"
        echo "2. $MSG_MENU_DEFAULT_2"
        echo "3. $MSG_MENU_DEFAULT_3"
        echo "4. $MSG_BACK"
        read -p "$MSG_CHOOSE" op
        case "$op" in
            1) dotfiles="end-4 dotfiles" ;;
            2) dotfiles="imperative-dots" ;;
            3) dotfiles="HyDE" ;;
            4) break ;;
            *) echo "$MSG_INVALID"; continue ;;
        esac

        logo
        echo "===== $MSG_MENU_DEFAULT_TITLE ====="
        echo "$MSG_CHOOSE_BROWSER"
        echo "1. 🦊 firefox"
        echo "2. 🔵 chromium"
        echo "3. 🦁 brave"
        echo "4. 🎭 opera"
        echo "5. 🧅 tor browser"
        echo "6. 🌀 zen browser"
        echo "7. $MSG_NONE"
        read -p "$MSG_CHOOSE" op_nav

        logo
        echo "===== $MSG_MENU_DEFAULT_TITLE ====="
        echo "$MSG_CHOOSE_EDITOR"
        echo "1. 💙 vscodium"
        echo "2. 🌊 windsurf"
        echo "3. ⚡ antigravity"
        echo "4. 💤 lazyvim"
        echo "5. $MSG_NONE"
        read -p "$MSG_CHOOSE" op_edit

        logo
        echo "===== $MSG_MENU_DEFAULT_TITLE ====="
        echo "$MSG_CHOOSE_LAUNCHER"
        echo "1. 🎮 steam"
        echo "2. 🦸 heroic games launcher"
        echo "3. $MSG_BOTH"
        echo "4. $MSG_NONE"
        read -p "$MSG_CHOOSE" op_launch

        logo
        echo "======================================="
        echo "$MSG_SUMMARY_TITLE"
        echo "${MSG_SUMMARY_DOTFILES}$dotfiles"
        case "$op_nav" in
            1) echo "${MSG_SUMMARY_BROWSER}firefox" ;;
            2) echo "${MSG_SUMMARY_BROWSER}chromium" ;;
            3) echo "${MSG_SUMMARY_BROWSER}brave" ;;
            4) echo "${MSG_SUMMARY_BROWSER}opera" ;;
            5) echo "${MSG_SUMMARY_BROWSER}tor browser" ;;
            6) echo "${MSG_SUMMARY_BROWSER}zen browser" ;;
        esac
        case "$op_edit" in
            1) echo "${MSG_SUMMARY_EDITOR}vscodium" ;;
            2) echo "${MSG_SUMMARY_EDITOR}windsurf" ;;
            3) echo "${MSG_SUMMARY_EDITOR}antigravity" ;;
            4) echo "${MSG_SUMMARY_EDITOR}lazyvim" ;;
        esac
        case "$op_launch" in
            1) echo "${MSG_SUMMARY_LAUNCHER}steam" ;;
            2) echo "${MSG_SUMMARY_LAUNCHER}heroic games launcher" ;;
            3) echo "${MSG_SUMMARY_LAUNCHER}steam + heroic" ;;
        esac
        echo "======================================="
        read -p "$MSG_PRESS_ENTER_START"

        case "$dotfiles" in
            "end-4 dotfiles") run_script "$SCRIPT_DIR/scripts/entornos/end4_completo.sh" ;;
            "imperative-dots") run_script "$SCRIPT_DIR/scripts/entornos/imperative-dots.sh" ;;
            "HyDE") run_script "$SCRIPT_DIR/scripts/entornos/hyde.sh" ;;
        esac

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
            4) run_script "$SCRIPT_DIR/scripts/editores/lazyvim.sh" ;;
        esac
        case "$op_launch" in
            1) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh" ;;
            2) run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh" ;;
            3) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh"
               run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh" ;;
        esac

        echo ""
        echo "$MSG_INSTALL_DONE"
        read -p "$MSG_REBOOT" confirm
        if [[ "$confirm" =~ ^[sySyOoJj]$ ]]; then
            sudo reboot
        fi
        break
    done
}

# ── inicio ─────────────────────────────────────────────────────
load_language

# ── menú principal ─────────────────────────────────────────────
while true; do
    logo
    echo "1. 🧰 $MSG_MENU_MAIN_1"
    echo "2. 🔧 $MSG_MENU_MAIN_2"
    echo "3. ⚙️  $MSG_MENU_MAIN_3"
    echo "4. 🚪 $MSG_MENU_MAIN_4"
    read -p "$MSG_CHOOSE" opcion
    case "$opcion" in
        1) menu_predeterminadas ;;
        2) menu_personalizadas ;;
        3) menu_ajustes ;;
        4) exit 0 ;;
        *) echo "$MSG_INVALID" ;;
    esac
done