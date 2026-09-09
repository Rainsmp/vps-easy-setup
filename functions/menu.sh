#!/usr/bin/env bash

access_network_menu() {
    while true; do
        clear

        echo
        echo "╭────────────────────────────────────────╮"
        echo "│          ACCESS & NETWORK              │"
        echo "╰────────────────────────────────────────╯"
        echo
        echo "1) Root Access"
        echo "2) Tailscale"
        echo "3) Zerotier"
        echo "4) Cloudflare DNS"
        echo
        echo "[SYSTEM OPERATIONS]"
        echo
        echo "5) System Info"
        echo "6) Port Forward"
        echo
        echo "[GUI & TERMINAL]"
        echo
        echo "7) Web Terminal"
        echo "8) RDP Installer"
        echo "9) SSL Panel"
        echo
        echo "0) Back"
        echo
        read -rp "➜ Select an option: " option

        case "$option" in
            1) root_access ;;
            2) tailscale_setup ;;
            3) zerotier_setup ;;
            4) cloudflare_dns ;;
            5) system_info ;;
            6) port_forward ;;
            7) web_terminal ;;
            8) rdp_installer ;;
            9) ssl_panel ;;
            0) return 0 ;;
            *)
                warning "Invalid option."
                sleep 1
                ;;
        esac
    done
}

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
        echo "  [9] ACCESS & NETWORK"
        echo
        echo "  [0] Exit"
        echo
        read -rp "➜ Select an option: " option

        case "$option" in
            1) basic_setup ;;
            2) update_system ;;
            3) setup_firewall ;;
            4) setup_hostname ;;
            5) setup_security ;;
            6) setup_ssh ;;
            7) setup_timezone ;;
            8) setup_user ;;
            9) access_network_menu ;;
            0) exit 0 ;;
            *)
                warning "Invalid option."
                sleep 1
                ;;
        esac
    done
}
