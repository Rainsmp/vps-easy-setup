#!/usr/bin/env bash

# ==============================
# VPS Easy Setup
# ==============================

REPO="https://raw.githubusercontent.com/Rainsmp/vps-easy-setup/main"
TEMP_DIR="/tmp/vps-easy-setup"

mkdir -p "$TEMP_DIR/functions"
mkdir -p "$TEMP_DIR/setup"

download_file() {
    local file="$1"

    curl -fsSL "$REPO/$file" -o "$TEMP_DIR/$file" || {
        echo "ERROR: Failed to download $file"
        exit 1
    }
}

download_file "functions/colors.sh"
download_file "functions/checks.sh"
download_file "functions/menu.sh"
download_file "setup/system.sh"

source "$TEMP_DIR/functions/colors.sh"
source "$TEMP_DIR/functions/checks.sh"
source "$TEMP_DIR/functions/menu.sh"
source "$TEMP_DIR/setup/system.sh"

show_menu

echo
info "Starting VPS setup..."
echo

check_system || exit 1

echo
read -rp "Start VPS setup? [Y/n]: " answer

case "$answer" in
    n|N)
        info "Setup cancelled."
        exit 0
        ;;
    *)
        system_setup
        ;;
esac
