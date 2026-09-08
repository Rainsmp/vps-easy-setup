#!/usr/bin/env bash

setup_firewall() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    info "Installing UFW..."

    DEBIAN_FRONTEND=noninteractive apt install -y ufw

    if [[ $? -ne 0 ]]; then
        error "Failed to install UFW."
        return 1
    fi

    success "UFW installed."

    echo
    info "Allowing SSH..."

    ufw allow OpenSSH >/dev/null 2>&1

    if [[ $? -ne 0 ]]; then
        error "Failed to allow SSH."
        return 1
    fi

    success "SSH access allowed."

    echo
    info "Enabling firewall..."

    ufw --force enable >/dev/null 2>&1

    if [[ $? -ne 0 ]]; then
        error "Failed to enable firewall."
        return 1
    fi

    success "Firewall enabled."
    echo

    ufw status

    echo
    pause_screen
}
