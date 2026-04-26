#!/bin/bash

SCRIPT_DIR="$HOME/.local/share/archy/archy"
LANG_FILE="$HOME/.local/share/archy/lang"
I18N_DIR="$SCRIPT_DIR/scripts/idioma"
MENU_RESULT=0
PATO_CACHE=""

# ocultar/mostrar cursor
cursor_hide() { printf "\e[?25l"; }
cursor_show() { printf "\e[?25h"; }

# asegurarse de mostrar cursor al salir
trap cursor_show EXIT

# ── idioma ─────────────────────────────────────────────────────
select_language() {
    clear
    cursor_show
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
    cursor_show
    if [ -f "$script" ]; then
        chmod +x "$script"
        bash "$script"
    else
        echo "$MSG_SCRIPT_NOT_FOUND$script"
        read -p "$MSG_PRESS_ENTER"
    fi
    cursor_hide
}

logo() {
    clear
    echo "==================================================================="
    if [ -z "$PATO_CACHE" ]; then
        PATO_CACHE=$(chafa "$SCRIPT_DIR/pato.png" --size 40x22 --colors 256)
    fi
    echo -e "$PATO_CACHE"
    echo " $MSG_HELLO"
    echo "==================================================================="
    echo ""
}

# ── navegación por flechas ─────────────────────────────────────
navigate_menu() {
    local title="$1"
    shift
    local options=("$@")
    local count=${#options[@]}
    local selected=0

    cursor_hide
    logo
    if [ -n "$title" ]; then
        echo "===== $title ====="
        echo ""
    fi

    draw_options() {
        for i in "${!options[@]}"; do
            tput el
            if [ "$i" -eq "$selected" ]; then
                echo -e "\e[7m  ${options[$i]}  \e[0m"
            else
                echo "  ${options[$i]}"
            fi
        done
    }

    draw_options

    while true; do
        local key
        IFS= read -rsn1 key
        if [[ "$key" == $'\x1b' ]]; then
            read -rsn2 -t 0.1 key
            case "$key" in
                '[A')
                    ((selected--))
                    [ "$selected" -lt 0 ] && selected=$((count-1))
                    tput cuu $count
                    draw_options
                    ;;
                '[B')
                    ((selected++))
                    [ "$selected" -ge "$count" ] && selected=0
                    tput cuu $count
                    draw_options
                    ;;
            esac
        elif [[ "$key" == "" ]]; then
            MENU_RESULT=$selected
            return
        fi
    done
}

# ── navegador ──────────────────────────────────────────────────
menu_navegador() {
    local opts=(
        "🦊 firefox"
        "🔵 chromium"
        "🦁 brave"
        "🎭 opera"
        "🧅 tor browser"
        "🌀 zen browser"
        "↩  $MSG_BACK"
    )
    navigate_menu "$MSG_MENU_BROWSER_TITLE" "${opts[@]}"
    case "$MENU_RESULT" in
        0) run_script "$SCRIPT_DIR/scripts/navegadores/firefox.sh" ;;
        1) run_script "$SCRIPT_DIR/scripts/navegadores/chromium.sh" ;;
        2) run_script "$SCRIPT_DIR/scripts/navegadores/brave.sh" ;;
        3) run_script "$SCRIPT_DIR/scripts/navegadores/opera.sh" ;;
        4) run_script "$SCRIPT_DIR/scripts/navegadores/tor.sh" ;;
        5) run_script "$SCRIPT_DIR/scripts/navegadores/zen.sh" ;;
        6) return ;;
    esac
}

# ── editor de código ───────────────────────────────────────────
menu_editor() {
    local opts=(
        "💙 vscodium"
        "🌊 windsurf"
        "⚡ antigravity"
        "💤 lazyvim"
        "↩  $MSG_BACK"
    )
    navigate_menu "$MSG_MENU_EDITOR_TITLE" "${opts[@]}"
    case "$MENU_RESULT" in
        0) run_script "$SCRIPT_DIR/scripts/editores/vscodium.sh" ;;
        1) run_script "$SCRIPT_DIR/scripts/editores/windsurf.sh" ;;
        2) run_script "$SCRIPT_DIR/scripts/editores/antigravity.sh" ;;
        3) run_script "$SCRIPT_DIR/scripts/editores/lazyvim.sh" ;;
        4) return ;;
    esac
}

# ── launcher de juegos ─────────────────────────────────────────
menu_launcher() {
    local opts=(
        "🎮 steam"
        "🦸 heroic games launcher"
        "🎮🦸 $MSG_BOTH"
        "↩  $MSG_BACK"
    )
    navigate_menu "$MSG_MENU_LAUNCHER_TITLE" "${opts[@]}"
    case "$MENU_RESULT" in
        0) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh" ;;
        1) run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh" ;;
        2) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh"
           run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh" ;;
        3) return ;;
    esac
}

# ── minecraft ─────────────────────────────────────────────────
menu_minecraft() {
    local opts=(
        "⛏️  minecraft oficial"
        "🏴‍☠️  tlauncher"
        "↩  $MSG_BACK"
    )
    navigate_menu "Minecraft" "${opts[@]}"
    case "$MENU_RESULT" in
        0) run_script "$SCRIPT_DIR/scripts/juegos/minecraft.sh" ;;
        1) run_script "$SCRIPT_DIR/scripts/juegos/tlauncher.sh" ;;
        2) return ;;
    esac
}

# ── juegos ─────────────────────────────────────────────────────
menu_juegos() {
    while true; do
        local opts=(
            "⛏️  minecraft"
            "↩  $MSG_BACK"
        )
        navigate_menu "$MSG_MENU_GAMES_TITLE" "${opts[@]}"
        case "$MENU_RESULT" in
            0) menu_minecraft ;;
            1) return ;;
        esac
    done
}

# ── programas ──────────────────────────────────────────────────
menu_utilidades() {
    local opts=(
        "🖥️  anydesk"
        "💾 timeshift"
        "🔒 keepassxc"
        "📁 thunar"
        "🖨️  cups"
        "↩  $MSG_BACK"
    )
    navigate_menu "$MSG_MENU_UTILS_TITLE" "${opts[@]}"
    case "$MENU_RESULT" in
        0) run_script "$SCRIPT_DIR/scripts/utilidades/anydesk.sh" ;;
        1) run_script "$SCRIPT_DIR/scripts/utilidades/timeshift.sh" ;;
        2) run_script "$SCRIPT_DIR/scripts/utilidades/keepassxc.sh" ;;
        3) run_script "$SCRIPT_DIR/scripts/utilidades/thunar.sh" ;;
        4) run_script "$SCRIPT_DIR/scripts/utilidades/cups.sh" ;;
        5) return ;;
    esac
}

menu_comunicacion() {
    local opts=(
        "💬 discord"
        "✈️  telegram"
        "💚 whatsapp"
        "🎵 spotify"
        "📹 zoom"
        "🟦 element"
        "↩  $MSG_BACK"
    )
    navigate_menu "$MSG_MENU_COMM_TITLE" "${opts[@]}"
    case "$MENU_RESULT" in
        0) run_script "$SCRIPT_DIR/scripts/comunicacion/discord.sh" ;;
        1) run_script "$SCRIPT_DIR/scripts/comunicacion/telegram.sh" ;;
        2) run_script "$SCRIPT_DIR/scripts/comunicacion/whatsapp.sh" ;;
        3) run_script "$SCRIPT_DIR/scripts/comunicacion/spotify.sh" ;;
        4) run_script "$SCRIPT_DIR/scripts/comunicacion/zoom.sh" ;;
        5) run_script "$SCRIPT_DIR/scripts/comunicacion/element.sh" ;;
        6) return ;;
    esac
}

menu_programas() {
    while true; do
        local opts=(
            "🌐 $MSG_MENU_PROGRAMS_1"
            "💻 $MSG_MENU_PROGRAMS_2"
            "🎮 $MSG_MENU_PROGRAMS_3"
            "🕹️  $MSG_MENU_PROGRAMS_4"
            "🛠️  $MSG_MENU_PROGRAMS_5"
            "💬 $MSG_MENU_PROGRAMS_6"
            "↩  $MSG_BACK"
        )
        navigate_menu "$MSG_MENU_PROGRAMS_TITLE" "${opts[@]}"
        case "$MENU_RESULT" in
            0) menu_navegador ;;
            1) menu_editor ;;
            2) menu_launcher ;;
            3) menu_juegos ;;
            4) menu_utilidades ;;
            5) menu_comunicacion ;;
            6) return ;;
        esac
    done
}

# ── entorno de escritorio ──────────────────────────────────────
menu_entorno() {
    while true; do
        local opts=(
            "🖥️  $MSG_MENU_ENTORNO_1"
            "🖥️ $MSG_MENU_ENTORNO_2"
            "🖥️ $MSG_MENU_ENTORNO_3"
            "🎨 $MSG_MENU_ENTORNO_4"
            "↩  $MSG_BACK"
        )
        navigate_menu "$MSG_MENU_ENTORNO_TITLE" "${opts[@]}"
        case "$MENU_RESULT" in
            0) run_script "$SCRIPT_DIR/scripts/entornos/end4_completo.sh"; return ;;
            1) run_script "$SCRIPT_DIR/scripts/entornos/imperative-dots.sh"; return ;;
            2) run_script "$SCRIPT_DIR/scripts/entornos/hyde.sh"; return ;;
            3) run_script "$SCRIPT_DIR/scripts/entornos/sddm.sh"; return ;;
            4) return ;;
        esac
    done
}

# ── instalaciones personalizadas ───────────────────────────────
menu_personalizadas() {
    while true; do
        local opts=(
            "🖥️ $MSG_MENU_CUSTOM_1"
            "📦 $MSG_MENU_CUSTOM_2"
            "↩  $MSG_BACK"
        )
        navigate_menu "$MSG_MENU_CUSTOM_TITLE" "${opts[@]}"
        case "$MENU_RESULT" in
            0) menu_entorno ;;
            1) menu_programas ;;
            2) return ;;
        esac
    done
}

# ── ajustes ────────────────────────────────────────────────────
update_archy() {
    cursor_show
    clear
    echo ">>> Actualizando archy..."
    REPO_URL="https://github.com/Edgares100IQ/archlinux-scripts.git"
    INSTALL_DIR="$HOME/.local/share/archy"
    LANG_BACKUP="$HOME/.local/share/archy/lang"
    TMP_DIR="/tmp/archy_update"
    local saved_lang=""
    [ -f "$LANG_BACKUP" ] && saved_lang=$(cat "$LANG_BACKUP")
    rm -rf "$TMP_DIR"
    git clone --depth 1 "$REPO_URL" "$TMP_DIR" &> /dev/null
    rm -rf "$INSTALL_DIR"
    mv "$TMP_DIR" "$INSTALL_DIR"
    [ -n "$saved_lang" ] && echo "$saved_lang" > "$LANG_BACKUP"
    chmod +x "$INSTALL_DIR/archy/archy.sh"
    find "$INSTALL_DIR/archy/scripts" -name "*.sh" -exec chmod +x {} \;
    echo ">>> archy actualizado"
    sleep 1
    cursor_hide
    exec bash "$INSTALL_DIR/archy/archy.sh"
}

menu_ajustes() {
    while true; do
        local opts=(
            "$MSG_MENU_SETTINGS_1"
            "$MSG_MENU_SETTINGS_2"
            "↩  $MSG_BACK"
        )
        navigate_menu "$MSG_MENU_SETTINGS_TITLE" "${opts[@]}"
        case "$MENU_RESULT" in
            0)
                rm -f "$LANG_FILE"
                select_language
                load_language
                ;;
            1) update_archy ;;
            2) return ;;
        esac
    done
}

# ── desinstalar navegador ──────────────────────────────────────
menu_desinstalar_navegador() {
    local opts=(
        "🦊 firefox"
        "🔵 chromium"
        "🦁 brave"
        "🎭 opera"
        "🧅 tor browser"
        "🌀 zen browser"
        "↩  $MSG_BACK"
    )
    navigate_menu "$MSG_MENU_BROWSER_TITLE" "${opts[@]}"
    case "$MENU_RESULT" in
        0) cursor_show; sudo pacman -Rns firefox --noconfirm; cursor_hide ;;
        1) cursor_show; sudo pacman -Rns chromium --noconfirm; cursor_hide ;;
        2) cursor_show; yay -Rns brave-bin --noconfirm; cursor_hide ;;
        3) cursor_show; yay -Rns opera --noconfirm; cursor_hide ;;
        4) cursor_show; yay -Rns tor-browser-bin --noconfirm; cursor_hide ;;
        5) cursor_show; yay -Rns zen-browser-bin --noconfirm; cursor_hide ;;
        6) return ;;
    esac
}

# ── desinstalar editor ─────────────────────────────────────────
menu_desinstalar_editor() {
    local opts=(
        "💙 vscodium"
        "🌊 windsurf"
        "⚡ antigravity"
        "💤 lazyvim"
        "↩  $MSG_BACK"
    )
    navigate_menu "$MSG_MENU_EDITOR_TITLE" "${opts[@]}"
    case "$MENU_RESULT" in
        0) cursor_show; yay -Rns vscodium-bin --noconfirm; cursor_hide ;;
        1) cursor_show; yay -Rns windsurf --noconfirm; cursor_hide ;;
        2) cursor_show; yay -Rns antigravity --noconfirm; cursor_hide ;;
        3) cursor_show; sudo pacman -Rns neovim --noconfirm && rm -rf ~/.config/nvim; cursor_hide ;;
        4) return ;;
    esac
}

# ── desinstalar launcher ───────────────────────────────────────
menu_desinstalar_launcher() {
    local opts=(
        "🎮 steam"
        "🦸 heroic games launcher"
        "↩  $MSG_BACK"
    )
    navigate_menu "$MSG_MENU_LAUNCHER_TITLE" "${opts[@]}"
    case "$MENU_RESULT" in
        0) cursor_show; flatpak uninstall com.valvesoftware.Steam -y; cursor_hide ;;
        1) cursor_show; yay -Rns heroic-games-launcher-bin --noconfirm; cursor_hide ;;
        2) return ;;
    esac
}

# ── desinstalar programas ──────────────────────────────────────
menu_desinstalar() {
    while true; do
        local opts=(
            "🌐 $MSG_MENU_PROGRAMS_1"
            "💻 $MSG_MENU_PROGRAMS_2"
            "🎮 $MSG_MENU_PROGRAMS_3"
            "↩  $MSG_BACK"
        )
        navigate_menu "$MSG_MENU_UNINSTALL_TITLE" "${opts[@]}"
        case "$MENU_RESULT" in
            0) menu_desinstalar_navegador ;;
            1) menu_desinstalar_editor ;;
            2) menu_desinstalar_launcher ;;
            3) return ;;
        esac
    done
}

# ── instalaciones predeterminadas ─────────────────────────────
menu_predeterminadas() {
    while true; do
        local opts=(
            "$MSG_MENU_DEFAULT_1"
            "$MSG_MENU_DEFAULT_2"
            "$MSG_MENU_DEFAULT_3"
            "↩  $MSG_BACK"
        )
        navigate_menu "$MSG_MENU_DEFAULT_TITLE" "${opts[@]}"
        local dotfiles
        case "$MENU_RESULT" in
            0) dotfiles="end-4 dotfiles" ;;
            1) dotfiles="imperative-dots" ;;
            2) dotfiles="HyDE" ;;
            3) return ;;
            *) continue ;;
        esac

        local nav_opts=(
            "🦊 firefox"
            "🔵 chromium"
            "🦁 brave"
            "🎭 opera"
            "🧅 tor browser"
            "🌀 zen browser"
            "$MSG_NONE"
        )
        navigate_menu "$MSG_CHOOSE_BROWSER" "${nav_opts[@]}"
        local op_nav=$MENU_RESULT

        local edit_opts=(
            "💙 vscodium"
            "🌊 windsurf"
            "⚡ antigravity"
            "💤 lazyvim"
            "$MSG_NONE"
        )
        navigate_menu "$MSG_CHOOSE_EDITOR" "${edit_opts[@]}"
        local op_edit=$MENU_RESULT

        local launch_opts=(
            "🎮 steam"
            "🦸 heroic games launcher"
            "🎮🦸 $MSG_BOTH"
            "$MSG_NONE"
        )
        navigate_menu "$MSG_CHOOSE_LAUNCHER" "${launch_opts[@]}"
        local op_launch=$MENU_RESULT

        logo
        echo "======================================="
        echo "$MSG_SUMMARY_TITLE"
        echo "${MSG_SUMMARY_DOTFILES}$dotfiles"
        case "$op_nav" in
            0) echo "${MSG_SUMMARY_BROWSER}firefox" ;;
            1) echo "${MSG_SUMMARY_BROWSER}chromium" ;;
            2) echo "${MSG_SUMMARY_BROWSER}brave" ;;
            3) echo "${MSG_SUMMARY_BROWSER}opera" ;;
            4) echo "${MSG_SUMMARY_BROWSER}tor browser" ;;
            5) echo "${MSG_SUMMARY_BROWSER}zen browser" ;;
        esac
        case "$op_edit" in
            0) echo "${MSG_SUMMARY_EDITOR}vscodium" ;;
            1) echo "${MSG_SUMMARY_EDITOR}windsurf" ;;
            2) echo "${MSG_SUMMARY_EDITOR}antigravity" ;;
            3) echo "${MSG_SUMMARY_EDITOR}lazyvim" ;;
        esac
        case "$op_launch" in
            0) echo "${MSG_SUMMARY_LAUNCHER}steam" ;;
            1) echo "${MSG_SUMMARY_LAUNCHER}heroic games launcher" ;;
            2) echo "${MSG_SUMMARY_LAUNCHER}steam + heroic" ;;
        esac
        echo "======================================="
        cursor_show
        read -p "$MSG_PRESS_ENTER_START"
        cursor_hide

        case "$dotfiles" in
            "end-4 dotfiles") run_script "$SCRIPT_DIR/scripts/entornos/end4_completo.sh" ;;
            "imperative-dots") run_script "$SCRIPT_DIR/scripts/entornos/imperative-dots.sh" ;;
            "HyDE") run_script "$SCRIPT_DIR/scripts/entornos/hyde.sh" ;;
        esac
        case "$op_nav" in
            0) run_script "$SCRIPT_DIR/scripts/navegadores/firefox.sh" ;;
            1) run_script "$SCRIPT_DIR/scripts/navegadores/chromium.sh" ;;
            2) run_script "$SCRIPT_DIR/scripts/navegadores/brave.sh" ;;
            3) run_script "$SCRIPT_DIR/scripts/navegadores/opera.sh" ;;
            4) run_script "$SCRIPT_DIR/scripts/navegadores/tor.sh" ;;
            5) run_script "$SCRIPT_DIR/scripts/navegadores/zen.sh" ;;
        esac
        case "$op_edit" in
            0) run_script "$SCRIPT_DIR/scripts/editores/vscodium.sh" ;;
            1) run_script "$SCRIPT_DIR/scripts/editores/windsurf.sh" ;;
            2) run_script "$SCRIPT_DIR/scripts/editores/antigravity.sh" ;;
            3) run_script "$SCRIPT_DIR/scripts/editores/lazyvim.sh" ;;
        esac
        case "$op_launch" in
            0) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh" ;;
            1) run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh" ;;
            2) run_script "$SCRIPT_DIR/scripts/launchers/steam.sh"
               run_script "$SCRIPT_DIR/scripts/launchers/heroic.sh" ;;
        esac

        echo ""
        echo "$MSG_INSTALL_DONE"
        cursor_show
        read -p "$MSG_REBOOT" confirm
        if [[ "$confirm" =~ ^[sySyOoJj]$ ]]; then
            sudo reboot
        fi
        return
    done
}

# ── inicio ─────────────────────────────────────────────────────
load_language

# ── menú principal ─────────────────────────────────────────────
while true; do
    opts=(
        "🧰 $MSG_MENU_MAIN_1"
        "🔧 $MSG_MENU_MAIN_2"
        "🗑️ $MSG_MENU_MAIN_3"
        "⚙️ $MSG_MENU_MAIN_4"
        "🚪 $MSG_MENU_MAIN_5"
    )
    navigate_menu "" "${opts[@]}"
    case "$MENU_RESULT" in
        0) menu_predeterminadas ;;
        1) menu_personalizadas ;;
        2) menu_desinstalar ;;
        3) menu_ajustes ;;
        4) clear
           echo
           echo "¡Espero que te haya servido de ayuda!"
           echo
           exit 0 ;;
    esac
done
