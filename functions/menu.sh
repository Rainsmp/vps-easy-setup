#!/usr/bin/env bash

show_menu() {
    while true; do
        clear

        echo
        echo "╭────────────────────────────────────────╮"
        echo "│              VPS SETUP                 │"
        echo "╰────────────────────────────────────────╯"
        echo
        echo "  [1] Basic VPS Setup"
        echo "  [2] Update System"
        echo "  [3] Firewall"
        echo "  [4] Hostname"
        echo "  [5] Security"
        echo "  [6] SSH Setup"
        echo "  [7] Timezone"
        echo "  [8] Create User"
        echo
        echo "  [0] Exit"
        echo
        read -rp "➜ Select an option: " option

        case "$option" in
            1)
                basic_setup
                ;;
            2)
                update_system
                ;;
            3)
                setup_firewall
                ;;
            4)
                setup_hostname
                ;;
            5)
                setup_security
                ;;
            6)
                setup_ssh
                ;;
            7)
                setup_timezone
                ;;
            8)
                setup_user
                ;;
            0)
                echo
                info "Goodbye."
                exit 0
                ;;
            *)
                echo
                warning "Invalid option."
                sleep 1
                ;;
        esac
    done
}
