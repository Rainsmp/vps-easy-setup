#!/usr/bin/env bash

check_root() {
    if [[ "$EUID" -ne 0 ]]; then
        error "Root access is required."
        return 1
    fi

    success "Root access confirmed"
}

check_os() {
    if [[ ! -f /etc/os-release ]]; then
        error "Unable to detect operating system."
        return 1
    fi

    source /etc/os-release

    if [[ "$ID" != "ubuntu" && "$ID" != "debian" && "$ID" != "kali" ]]; then
        warning "This VPS is not running a supported Debian-based distribution."
        return 1
    fi

    success "Operating system: $PRETTY_NAME"
}

check_internet() {
    info "Checking internet connection..."

    if curl -fsS --connect-timeout 5 https://github.com >/dev/null 2>&1; then
        success "Internet connection available"
        return 0
    fi

    error "Internet connection unavailable."
    return 1
}

check_system() {
    check_root || return 1
    check_os || return 1
    check_internet || return 1

    success "All system checks passed"
}
