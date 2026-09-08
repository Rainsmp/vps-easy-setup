#!/usr/bin/env bash

REPO="https://raw.githubusercontent.com/Rainsmp/vps-easy-setup/main"
TEMP_DIR="/tmp/vps-easy-setup"

mkdir -p "$TEMP_DIR/functions"
mkdir -p "$TEMP_DIR/setup"
mkdir -p "$TEMP_DIR/config"

download_file() {
    local file="$1"

    curl -fsSL "$REPO/$file" -o "$TEMP_DIR/$file" || {
        echo "ERROR: Failed to download $file"
        exit 1
    }
}

download_file "functions/colors.sh"
download_file "functions/checks.sh"
download_file "functions/input.sh"
download_file "functions/menu.sh"
download_file "functions/progress.sh"
download_file "functions/utils.sh"

download_file "config/defaults.conf"

download_file "setup/basic.sh"
download_file "setup/updates.sh"
download_file "setup/firewall.sh"
download_file "setup/hostname.sh"
download_file "setup/security.sh"
download_file "setup/ssh.sh"
download_file "setup/timezone.sh"
download_file "setup/user.sh"

source "$TEMP_DIR/functions/colors.sh"
source "$TEMP_DIR/functions/checks.sh"
source "$TEMP_DIR/functions/input.sh"
source "$TEMP_DIR/functions/menu.sh"
source "$TEMP_DIR/functions/progress.sh"
source "$TEMP_DIR/functions/utils.sh"

source "$TEMP_DIR/config/defaults.conf"

source "$TEMP_DIR/setup/basic.sh"
source "$TEMP_DIR/setup/updates.sh"
source "$TEMP_DIR/setup/firewall.sh"
source "$TEMP_DIR/setup/hostname.sh"
source "$TEMP_DIR/setup/security.sh"
source "$TEMP_DIR/setup/ssh.sh"
source "$TEMP_DIR/setup/timezone.sh"
source "$TEMP_DIR/setup/user.sh"

echo
info "Checking VPS..."
echo

check_system || exit 1

show_menu
