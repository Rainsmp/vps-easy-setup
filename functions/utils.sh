#!/usr/bin/env bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

get_os_name() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "${PRETTY_NAME:-Unknown}"
    else
        echo "Unknown"
    fi
}

get_ram() {
    free -h | awk '/^Mem:/ {print $2}'
}

get_disk() {
    df -h / | awk 'NR==2 {print $2}'
}

get_cpu() {
    nproc
}

get_uptime() {
    uptime -p 2>/dev/null || echo "Unknown"
}

pause_screen() {
    echo
    read -rp "Press Enter to continue..."
}
