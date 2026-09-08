#!/usr/bin/env bash

# ==============================
# VPS Easy Setup - System Setup
# ==============================

system_setup() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    info "Updating VPS packages..."
    apt update -y

    if [[ $? -ne 0 ]]; then
        error "Package update failed."
        return 1
    fi

    success "Packages updated."

    echo
    info "Upgrading VPS packages..."
    DEBIAN_FRONTEND=noninteractive apt upgrade -y

    if [[ $? -ne 0 ]]; then
        error "Package upgrade failed."
        return 1
    fi

    success "Packages upgraded."

    echo
    info "Installing basic VPS tools..."
    DEBIAN_FRONTEND=noninteractive apt install -y \
        curl \
        wget \
        git \
        unzip \
        zip \
        nano \
        sudo \
        ca-certificates

    if [[ $? -ne 0 ]]; then
        error "Failed to install basic tools."
        return 1
    fi

    success "Basic VPS tools installed."

    echo
    line
    success "VPS setup completed successfully."
    line
}
