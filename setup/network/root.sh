#!/usr/bin/env bash

root_access() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              ROOT ACCESS               │"
    echo "╰────────────────────────────────────────╯"
    echo

    if [[ "$EUID" -eq 0 ]]; then
        success "Root access confirmed."
    else
        error "Root access is required."
    fi

    pause
}
