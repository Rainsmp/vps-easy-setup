#!/usr/bin/env bash

# ==============================
# VPS Easy Setup - VPS Checks
# ==============================

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

    success "Operating System: ${PRETTY_NAME:-Unknown}"
}

check_vps_info() {
    echo
    line
    title "VPS INFORMATION"
    line

    echo "OS       : $(. /etc/os-release && echo "$PRETTY_NAME")"
    echo "Hostname : $(hostname)"
    echo "CPU      : $(nproc) cores"
    echo "RAM      : $(free -h | awk '/Mem:/ {print $2}')"
    echo "Disk     : $(df -h / | awk 'NR==2 {print $2}')"
    echo "Uptime   : $(uptime -p)"

    line
}

check_system() {
    check_root || return 1
    check_os || return 1
    check_vps_info
}
