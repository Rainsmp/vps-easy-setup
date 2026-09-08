#!/usr/bin/env bash

setup_security() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    info "Installing security updates..."

    DEBIAN_FRONTEND=noninteractive apt install -y \
        unattended-upgrades \
        apt-listchanges

    if [[ $? -ne 0 ]]; then
        error "Failed to install security packages."
        return 1
    fi

    success "Security packages installed."

    echo
    info "Enabling automatic security updates..."

    dpkg-reconfigure -f noninteractive unattended-upgrades >/dev/null 2>&1

    if [[ $? -ne 0 ]]; then
        error "Failed to enable automatic updates."
        return 1
    fi

    success "Automatic security updates enabled."

    echo
    info "Applying basic network protection..."

    cat <<'SYSCTL' > /etc/sysctl.d/99-vps-easy-setup.conf
# VPS Easy Setup - Basic Network Security
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1
net.ipv4.icmp_echo_ignore_broadcasts=1
SYSCTL

    if ! sysctl --system >/dev/null 2>&1; then
        error "Failed to apply network protection."
        return 1
    fi

    success "Basic network protection enabled."

    echo
    pause_screen
}
