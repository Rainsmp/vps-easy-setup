#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/functions/colors.sh"
source "$SCRIPT_DIR/functions/checks.sh"
source "$SCRIPT_DIR/functions/menu.sh"
source "$SCRIPT_DIR/setup/system.sh"

show_menu

echo
info "Starting VPS setup..."
echo

check_system || exit 1

echo
system_setup
