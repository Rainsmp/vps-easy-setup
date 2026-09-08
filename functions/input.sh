#!/usr/bin/env bash

ask_yes_no() {
    local question="$1"
    local answer

    while true; do
        read -rp "$question [Y/n]: " answer

        case "$answer" in
            ""|y|Y|yes|YES|Yes)
                return 0
                ;;
            n|N|no|NO|No)
                return 1
                ;;
            *)
                warning "Please answer Y or N."
                ;;
        esac
    done
}

ask_input() {
    local question="$1"
    local default="$2"
    local answer

    if [[ -n "$default" ]]; then
        read -rp "$question [$default]: " answer
        echo "${answer:-$default}"
    else
        read -rp "$question: " answer
        echo "$answer"
    fi
}
