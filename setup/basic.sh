#!/usr/bin/env bash

basic_setup() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    info "Installing essential VPS packages..."

    DEBIAN_FRONTEND=noninteractive apt install -y \
        curl \
        wget \
        git \
        unzip \
        zip \
        sudo \
        ca-certificates

    if [[ $? -ne 0 ]]; then
        error "Failed to install essential packages."
        return 1
    fi

    success "Essential packages installed."

    echo
    info "Cleaning package cache..."

    apt autoremove -y
    apt autoclean -y

    success "Package cleanup completed."

    echo
    success "Basic VPS setup completed."

    pause_screen
}
