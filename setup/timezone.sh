#!/usr/bin/env bash

setup_timezone() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    local current_timezone
    current_timezone="$(timedatectl show --property=Timezone --value 2>/dev/null)"

    info "Current timezone: ${current_timezone:-Unknown}"
    echo

    read -rp "➜ Enter timezone (example: Asia/Dhaka): " new_timezone

    if [[ -z "$new_timezone" ]]; then
        info "Timezone unchanged."
        pause_screen
        return 0
    fi

    if ! timedatectl list-timezones | grep -Fxq "$new_timezone"; then
        error "Invalid timezone: $new_timezone"
        pause_screen
        return 1
    fi

    timedatectl set-timezone "$new_timezone"

    if [[ $? -ne 0 ]]; then
        error "Failed to change timezone."
        pause_screen
        return 1
    fi

    success "Timezone changed to: $new_timezone"
    pause_screen
}
