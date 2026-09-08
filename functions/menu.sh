#!/usr/bin/env bash

# ==============================
# VPS Easy Setup
# ==============================

show_menu() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo
}

get_menu_choice() {
    read -rp "➜ Choose an option: " choice
    echo
}
