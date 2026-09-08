#!/usr/bin/env bash

setup_hostname() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    local current_hostname
    current_hostname="$(hostname)"

    info "Current hostname: $current_hostname"
    echo

    read -rp "➜ Enter new hostname (leave empty to keep current): " new_hostname

    if [[ -z "$new_hostname" ]]; then
        info "Hostname unchanged."
        pause_screen
        return 0
    fi

    if [[ ! "$new_hostname" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]*$ ]]; then
        error "Invalid hostname."
        pause_screen
        return 1
    fi

    hostnamectl set-hostname "$new_hostname"

    if [[ $? -ne 0 ]]; then
        error "Failed to change hostname."
        pause_screen
        return 1
    fi

    success "Hostname changed to: $new_hostname"
    pause_screen
}
