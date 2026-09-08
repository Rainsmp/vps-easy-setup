#!/usr/bin/env bash

update_system() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    info "Updating package lists..."
    apt update -y

    if [[ $? -ne 0 ]]; then
        error "Package list update failed."
        return 1
    fi

    success "Package lists updated."

    echo
    info "Upgrading installed packages..."
    DEBIAN_FRONTEND=noninteractive apt upgrade -y

    if [[ $? -ne 0 ]]; then
        error "Package upgrade failed."
        return 1
    fi

    success "System packages upgraded."
    echo

    pause_screen
}
