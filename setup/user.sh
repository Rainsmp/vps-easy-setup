#!/usr/bin/env bash

setup_user() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              VPS SETUP                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    read -rp "➜ Enter username to create: " new_user

    if [[ -z "$new_user" ]]; then
        error "Username cannot be empty."
        pause_screen
        return 1
    fi

    if [[ ! "$new_user" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        error "Invalid username."
        pause_screen
        return 1
    fi

    if id "$new_user" >/dev/null 2>&1; then
        warning "User '$new_user' already exists."
        pause_screen
        return 0
    fi

    info "Creating user '$new_user'..."

    adduser --disabled-password --gecos "" "$new_user"

    if [[ $? -ne 0 ]]; then
        error "Failed to create user."
        pause_screen
        return 1
    fi

    success "User '$new_user' created."

    echo
    info "Adding user to sudo group..."

    usermod -aG sudo "$new_user"

    if [[ $? -ne 0 ]]; then
        error "Failed to add user to sudo group."
        pause_screen
        return 1
    fi

    success "User added to sudo group."

    echo
    info "Setting user password..."

    passwd "$new_user"

    if [[ $? -ne 0 ]]; then
        error "Failed to set password."
        pause_screen
        return 1
    fi

    success "User setup completed."
    echo

    pause_screen
}
