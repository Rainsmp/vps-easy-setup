#!/usr/bin/env bash

setup_ssh() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    info "Installing OpenSSH server..."

    DEBIAN_FRONTEND=noninteractive apt install -y openssh-server

    if [[ $? -ne 0 ]]; then
        error "Failed to install OpenSSH server."
        return 1
    fi

    success "OpenSSH server installed."

    echo
    info "Enabling SSH service..."

    systemctl enable ssh >/dev/null 2>&1
    systemctl start ssh >/dev/null 2>&1

    if [[ $? -ne 0 ]]; then
        error "Failed to start SSH service."
        return 1
    fi

    success "SSH service is running."

    echo
    pause_screen
}
