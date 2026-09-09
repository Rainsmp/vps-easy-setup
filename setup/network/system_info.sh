#!/usr/bin/env bash

system_info() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│               SYSTEM INFO              │"
    echo "╰────────────────────────────────────────╯"
    echo

    echo "OS:      $(get_os_name)"
    echo "CPU:     $(get_cpu) cores"
    echo "RAM:     $(get_ram)"
    echo "Disk:    $(get_disk)"
    echo "Uptime:  $(get_uptime)"
    echo "Kernel:  $(uname -r)"
    echo

    pause
}
